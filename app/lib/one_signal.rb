class OneSignal
  attr_accessor :app_id, :api_key

  def initialize
    @app_id = ENV['ONE_SIGNAL_APP_ID'] || nil
    @api_key = ENV['ONE_SIGNAL_API_KEY'] || nil
    @base_url = 'https://onesignal.com/api/v1'
  end

  def push_to_segments(headings, contents, segments)
    body = {
      app_id: @app_id,
      included_segments: segments,
      headings: { 'en': headings },
      contents: { 'en': contents }
    }.to_json

    begin
      Faraday.post("#{@base_url}/notifications") do |req|
        req.headers = request_headers
        req.body = body
      end
    rescue Faraday::Error => e
      Rails.logger.warn e
    end
  end

  def push_to_users(headings, contents, users)
    body = {
      app_id: @app_id,
      include_external_user_ids: users,
      headings: { 'en': headings },
      contents: { 'en': contents }
    }.to_json

    begin
      Faraday.post("#{@base_url}/notifications") do |req|
        req.headers = request_headers
        req.body = body
      end
    rescue Faraday::Error => e
      Rails.logger.warn e
    end
  end

  private

  def request_headers
    {
      'Authorization': "Basic #{@api_key}",
      'Content-Type': 'application/json'
    }
  end
end
