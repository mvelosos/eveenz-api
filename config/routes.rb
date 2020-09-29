# == Route Map
#
#                             Prefix Verb   URI Pattern                                                                              Controller#Action
#                        sidekiq_web        /jobs                                                                                    Sidekiq::Web
#                       api_v1_users POST   /api/v1/users(.:format)                                                                  api/v1/users#create {:format=>:json}
#                        api_v1_user GET    /api/v1/users/:username(.:format)                                                        api/v1/users#show {:format=>:json}
#                    api_v1_accounts PATCH  /api/v1/accounts(.:format)                                                               api/v1/accounts#update {:format=>:json}
#                                    PUT    /api/v1/accounts(.:format)                                                               api/v1/accounts#update {:format=>:json}
#                                    POST   /api/v1/accounts/follows/accounts/:id(.:format)                                          api/v1/follows#follow_account {:format=>:json}
#                                    DELETE /api/v1/accounts/follows/accounts/:id(.:format)                                          api/v1/follows#unfollow_account {:format=>:json}
#                                    POST   /api/v1/accounts/follows/events/:id(.:format)                                            api/v1/follows#follow_event {:format=>:json}
#                                    DELETE /api/v1/accounts/follows/events/:id(.:format)                                            api/v1/follows#unfollow_event {:format=>:json}
#                                    GET    /api/v1/accounts(.:format)                                                               api/v1/accounts#index {:format=>:json}
#   follow_account_api_v1_me_follows POST   /api/v1/me/follows/follow_account(.:format)                                              api/v1/follows#follow_account {:format=>:json}
# unfollow_account_api_v1_me_follows DELETE /api/v1/me/follows/unfollow_account(.:format)                                            api/v1/follows#unfollow_account {:format=>:json}
#     follow_event_api_v1_me_follows POST   /api/v1/me/follows/follow_event(.:format)                                                api/v1/follows#follow_event {:format=>:json}
#   unfollow_event_api_v1_me_follows DELETE /api/v1/me/follows/unfollow_event(.:format)                                              api/v1/follows#unfollow_event {:format=>:json}
#                          api_v1_me GET    /api/v1/me(.:format)                                                                     api/v1/me#show {:format=>:json}
#                 mine_api_v1_events GET    /api/v1/events/mine(.:format)                                                            api/v1/events#mine {:format=>:json}
#            confirmed_api_v1_events GET    /api/v1/events/confirmed(.:format)                                                       api/v1/events#confirmed {:format=>:json}
#                      api_v1_events GET    /api/v1/events(.:format)                                                                 api/v1/events#index {:format=>:json}
#                                    POST   /api/v1/events(.:format)                                                                 api/v1/events#create {:format=>:json}
#            login_api_v1_auth_index POST   /api/v1/auth/login(.:format)                                                             api/v1/auth#login {:format=>:json}
#         facebook_api_v1_auth_index POST   /api/v1/auth/facebook(.:format)                                                          api/v1/auth#facebook {:format=>:json}
#                api_v1_search_index GET    /api/v1/search(.:format)                                                                 api/v1/search#index {:format=>:json}
#                             api_v1 GET    /api/v1/*a(.:format)                                                                     api/v1/api#not_found {:format=>:json}
#                 rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#          rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                 rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#          update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#               rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobs'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users, param: :username, only: %i[show create]
      resource  :accounts, only: [:update]
      resources :accounts, only: [:index] do
        collection do
          post   'follows/accounts/:id', to: 'follows#follow_account'
          delete 'follows/accounts/:id', to: 'follows#unfollow_account'
          post   'follows/events/:id', to: 'follows#follow_event'
          delete 'follows/events/:id', to: 'follows#unfollow_event'
        end
      end
      resource :me, controller: :me, only: %i[show] do
        resource :follows, only: %i[] do
          post :follow_account
          delete :unfollow_account
          post :follow_event
          delete :unfollow_event
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
