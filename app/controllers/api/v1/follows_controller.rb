module Api
  module V1
    class FollowsController < Api::V1::ApiController
      before_action :set_follow_account, only: %i[follow_account unfollow_account]
      before_action :set_follow_event, only: %i[follow_event unfollow_event]

      # POST /accounts/follows/accounts/:id
      def follow_account
        if current_user.account.follow(@follow_account)
          render json: { message: 'account followed with success' }, status: :created
        else
          render json: { errors: current_user.account.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /accounts/follows/accounts/:id
      def unfollow_account
        if current_user.account.stop_following(@follow_account)
          render json: { message: 'account unfollowed with success' }
        else
          render json: { errors: current_user.account.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /accounts/follows/events/:id
      def follow_event
        if current_user.account.follow(@follow_event)
          render json: { message: 'event followed with success' }, status: :created
        else
          render json: { errors: current_user.account.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /accounts/follows/events/:id
      def unfollow_event
        if current_user.account.stop_following(@follow_event)
          render json: { message: 'event unfollowed with success' }
        else
          render json: { errors: current_user.account.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_follow_account
        @follow_account = Account.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :not_found
      end

      def set_follow_event
        @follow_event = Event.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :not_found
      end
    end
  end
end
