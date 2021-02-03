module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = ENV['FACEBOOK_APP_ID']
      client_secret = ENV['FACEBOOK_APP_SECRET']
      token = 'EAAJXl0kUqRkBANj4IXesGogNPi9o5iOZCeuplomrZA4MikvJhqyvhG8vlQgL25DzdhzOJ1rwhEKpCHoBhbPJ3'\
              'ZBznZCKkElvkY2hSl07kgo3WjjJRNzwPtEqFQdZAHsYh9RoRIMTXanAMfjLthulxRdo5S3VD07o7pBCyhAVRVKB7NENygw6S'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end
