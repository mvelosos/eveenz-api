module ErrorMessages
  extend ActiveSupport::Concern

  def unable_to_authenticate(message)
    render json: { error: message }, status: :not_acceptable
  end

  def access_denied(error_message = 'Unauthorized Request')
    render json: { error: error_message }.to_json, status: :unauthorized
    false
  end

  def not_acceptable(error_message)
    if !error_message.is_a?(String) && error_message.respond_to?(:errors)
      error_message = error_message.errors.messages.values.flatten
    end
    render json: { error: error_message }, status: :not_acceptable
    false
  end

  def content_not_found(error_message)
    render json: { error: error_message }, status: :not_found
    false
  end
end
