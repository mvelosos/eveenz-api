require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobs'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :accounts, param: :username, only: %i[show], constraints: { username: /[0-z\.]+/ } do
        member do
          get :followers
          get :following
        end
      end

      resources :events, only: [:index, :create]
      resources :search, only: [:index]
      resources :users, only: %i[create] do
        collection do
          get :username_available
        end
      end

      resources :auth, only: [] do
        collection do
          post :login
          post :facebook
        end
      end

      resource :me, controller: :me, only: %i[show update] do
        collection do
          get '/events/mine', to: 'me#mine'
          get '/events/confirmed', to: 'me#confirmed'
        end
        resource :follows, only: [] do
          post   '/accounts/:uuid', to: 'follows#follow_account'
          delete '/accounts/:uuid', to: 'follows#unfollow_account'
          post   '/events/:uuid', to: 'follows#follow_event'
          delete '/events/:uuid', to: 'follows#unfollow_event'
        end
      end

      resource :passwords, only: [] do
        post :forgot
        post :verify_code
        post :recover_password
      end

      get '/*a', to: 'api#not_found'
    end
  end
end
