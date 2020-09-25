module Api
  module V1
    class SearchController < Api::V1::ApiController
      # GET /search?query=
      def index
        users    = User.search(params[:query], page: (params[:page] || 1))
        accounts = Account.search(params[:query], page: (params[:page] || 1))
        events   = Event.search(params[:query], page: (params[:page] || 1))

        accounts_from_users = []
        users.each do |user|
          accounts_from_users << user.account
        end

        accounts = accounts.to_a.concat(accounts_from_users).uniq

        accounts_json = ActiveModelSerializers::SerializableResource.new(accounts, each_serializer: AccountSerializer)
        events_json   = ActiveModelSerializers::SerializableResource.new(events, each_serializer: EventSerializer, current_user: current_user)

        render json: { users: accounts_json, events: events_json }, status: :ok
      end
    end
  end
end
