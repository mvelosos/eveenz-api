class Api::V1::ApiController < ApplicationController
  include ApiListMethods
  include Authenticators
  include ErrorMessages
  include Miscellaneous
  include ObjectResponders
  include ParamSetters

  before_action :authenticate_by_token
  before_action :sentry_context

  serialization_scope :current_user

  attr_accessor :current_user

  def not_found
    content_not_found('route not found')
  end
end
