class Api::V1::PasswordsController < Api::V1::ApiController
  before_action :authenticate_by_token, except: [:forgot]
  before_action :user, only: %i[forgot]

  def forgot
    UserRecoveryPasswordJob.perform_later(@user.id)
    render json: "Um email foi enviado para #{@user.email} contendo as instruções", status: :ok
  end

  def update; end

  private

  def user
    @user = User.find_by_email!(forgot_params[:email])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User #{forgot_params[:email]} not found" }, status: :not_found
  end

  def forgot_params
    params.require(:password).permit(
      :email
    ).to_unsafe_h
  end
end
