module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = ''
      client_secret = ''
      token = ''

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# Get long live auth_token
# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret={secrete}&fb_exchange_token={token}"

# Check user permissions
# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token={token}&debug=all'
