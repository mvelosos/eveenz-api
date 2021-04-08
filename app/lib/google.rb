class Google
  @url = 'https://www.googleapis.com/oauth2/v1/userinfo?access_token='

  def self.info(access_token)
    response = Faraday.get("#{@url}#{access_token}")
    JSON.parse(response.body)
  end
end
