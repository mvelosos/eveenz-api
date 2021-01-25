class Api::V1::PasswordsController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[forgot verify_code recover_password]
  before_action :user, only: %i[forgot]

  def forgot
    if @user.provider != 'api'
      return render json: {
        message: "Sua conta foi cadastrada através do #{@user.provider.humanize}. "\
        "Por favor, faça login utlizando o #{@user.provider.humanize}"
      }
    end

    UserRecoveryPasswordJob.perform_later(@user.id)
    render json: { valid: true, email: @user.email }, status: :ok
  end

  def verify_code
    @password_recovery = PasswordRecovery.find_by_code!(recover_password_params[:code])
    @password_recovery.update(token: SecureRandom.hex(16)) if @password_recovery.token.nil?
    render json: { valid: true, token: @password_recovery.token }, status: :accepted
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'O código de verificação informado não é válido!' }, status: :bad_request
  end

  def recover_password
    if recover_password_params[:password] != recover_password_params[:password_confirmation]
      return render json: { error: 'As a senhas não coincidem!' }, status: :bad_request
    end

    @password_recovery = PasswordRecovery.find_by_token!(recover_password_params[:token])
    @user = @password_recovery.user

    @password_recovery.destroy! if @user.update(password: recover_password_params[:password])

    render json: { valid: true, message: 'Senha alterada com sucesso!' }, status: :accepted
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Erro ao recuperar senha, tente novamente mais tarde' }, status: :bad_request
  end

  private

  def user
    @user = User.find_by_email(forgot_params[:login]) || User.find_by_username!(forgot_params[:login])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'E-mail ou nome de usuário informado não existe!' }, status: :bad_request
  end

  def forgot_params
    params.require(:password).permit(
      :login
    ).to_unsafe_h.to_snake_keys.symbolize_keys
  end

  def recover_password_params
    params.require(:passwordRecovery).permit(
      :code,
      :token,
      :password,
      :passwordConfirmation
    ).to_unsafe_h.to_snake_keys.symbolize_keys
  end
end
