module Miscellaneous
  extend ActiveSupport::Concern

  def set_raven_context
    if current_user
      Raven.user_context(id: current_user.id, username: current_user.account.username)
    else
      Raven.user_context(message: 'user not authenticated')
    end
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
