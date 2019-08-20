module Api
  module V1
    class AccountsController < ApiController

      # PATCH /accounts
      def update
        @account = current_user.account
        if @account.update(account_params)
          render json: '', status: :no_content
        else
          render json: { error: @account.errors.full_messages}, status: :not_acceptable
        end
      end

      private
        def account_params
          params.require(:account).permit(:name, :bio, :latitude, :longitude)
        end

    end 
  end
end
