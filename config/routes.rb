require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobs'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users, param: :username, only: %i[show create]
      resource  :accounts, only: [:update]
      resources :accounts, only: [:index] do
        collection do
          get 'following', to: 'accounts#following'
          get 'followers', to: 'accounts#followers'
          post   'follows/accounts/:id', to: 'follows#follow_account'
          delete 'follows/accounts/:id', to: 'follows#unfollow_account'
          post   'follows/events/:id', to: 'follows#follow_event'
          delete 'follows/events/:id', to: 'follows#unfollow_event'
        end
      end

      resources :events, only: [:index, :create] do
        collection do
          get :mine
          get :confirmed
        end
      end

      resources :auth, only: [] do
        collection do
          post :login
          post :facebook
        end
      end

      resources :search, only: [:index]

      get '/*a', to: 'api#not_found'
    end
  end
end
