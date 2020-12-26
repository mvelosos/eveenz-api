require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobs'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :accounts, param: :username, only: %i[show]
      resources :events, only: [:index, :create]
      resources :search, only: [:index]
      resources :users, only: %i[create]

      resources :auth, only: [] do
        collection do
          post :login
          post :facebook
        end
      end

      resource :me, controller: :me, only: %i[show update] do
        get :following
        get :followers
        resource :events, only: [] do
          get :mine
          get :confirmed
        end
        resource :follows, only: [] do
          post   '/accounts/:id', to: 'follows#follow_account'
          delete '/accounts/:id', to: 'follows#unfollow_account'
          post   '/events/:id', to: 'follows#follow_event'
          delete '/events/:id', to: 'follows#unfollow_event'
        end
      end

      get '/*a', to: 'api#not_found'
    end
  end
end
