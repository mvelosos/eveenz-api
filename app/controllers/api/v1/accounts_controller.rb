module Api
  module V1
    class AccountsController < ApiController

      def update
        
      end

      private
        def account_params
          params.require(:account).permit(:name, :bio, :latitude, :longitude)
        end

    end 
  end
end
