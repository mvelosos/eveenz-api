class Api::V1::Notifications::PushNotificationsService
  def initialize
    @client = OneSignal.new
  end

  def push_to_segments(headings, contents, segments)
    return Rails.logger.warn('No OneSignal app_id provided!') if @client.app_id.nil?
    return Rails.logger.warn('No OneSignal api_key provided!') if @client.api_key.nil?

    @client.push_to_segments(headings, contents, segments)
  end

  def push_to_users(headings, contents, users)
    return Rails.logger.warn('No OneSignal app_id provided') if @client.app_id.nil?
    return Rails.logger.warn('No OneSignal api_key provided!') if @client.api_key.nil?

    @client.push_to_users(headings, contents, users)
  end
end
