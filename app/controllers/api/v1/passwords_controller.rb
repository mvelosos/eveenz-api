class Api::V1::PasswordsController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[forgot update]
  before_action :user, only: %i[forgot]

  def forgot
    UserRecoveryPasswordJob.perform_later(@user.id)
    render json: { valid: true, email: @user.email }, status: :ok
  end

  def verify_code; end

  def update; end

  private

  def user
    @user = User.find_by_email!(forgot_params[:email])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'O e-mail informado não é válido!' }, status: :not_found
  end

  def forgot_params
    params.require(:password).permit(
      :email
    ).to_unsafe_h
  end
end
