class Api::V1::WebhooksController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[sign_in_with_apple]

  def sign_in_with_apple
    p params
  end
end
