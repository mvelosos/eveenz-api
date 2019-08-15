module Api
  module V1
    class AccountsController < ApiController

      # PATCH /accounts
      def update
        begin 
          if current_user.account.update(account_params)
            render json: '', status: :no_content
          end
        rescue StandardError => e
          Rails.logger.info("Account update error:  #{e}")
          render json: 'something occured', status: :not_acceptable
        end
      end

      private
        def account_params
          params.require(:account).permit(:name, :bio, :latitude, :longitude)
        end

    end 
  end
end
