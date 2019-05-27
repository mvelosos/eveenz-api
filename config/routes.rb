Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users, param: :username, only: [:show, :create, :update]
      post '/auth/login', to: 'authentication#login'
      post '/auth/facebook', to: 'authentication#facebook'
      get '/*a', to: 'api#not_found'

    end
  end

end
