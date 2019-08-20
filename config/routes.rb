Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users, param: :username, only: [:show, :create] do
        collection do
          patch '', to: 'users#update'
        end
      end
      
      resource :accounts, only: [:update]

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
