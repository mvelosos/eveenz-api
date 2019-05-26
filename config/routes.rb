Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users, param: :_username
      post '/auth/login', to: 'authentication#login'
      get '/*a', to: 'api#not_found'

    end
  end

end
