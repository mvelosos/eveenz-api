Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users, param: :username, only: [:show, :create] do
        collection do
          patch '', to: 'users#update'
        end
      end
      
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

      resources :events, only: [:index] do
        collection do
          get 'my-events', to: 'events#my_events'
        end
      end

      resources 'auth', only: [] do
        collection do
          post 'login', to: 'authentication#login'
          post 'facebook', to: 'authentication#facebook'
        end
      end

      get '/*a', to: 'api#not_found'

    end
  end
end
