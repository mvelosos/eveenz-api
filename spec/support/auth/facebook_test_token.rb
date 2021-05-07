module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAH9R6kxqHMrYJ2roDf2XxqZCfoV7ftn5ajFJ9sbjEVTyB7YZAL3ObvV7uhvjm7ZCygPtFCRSw8rqJXBiM6VIGU1j'\
              'hhihp1L9lQWx0s5nsbFUijezoZAuRFxz1ODY3td69mjvCB34wFsOMsKCaUNB67s47000oSqFJHx5rRjT7otn0IwAxREsDCZAitVQBpQZDZD'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# Get long live auth_token
# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBAH9R6kxqHMrYJ2roDf2XxqZCfoV7ftn5ajFJ9sbjEVTyB7YZAL3ObvV7uhvjm7ZCygPtFCRSw8rqJXBiM6VIGU1jhhihp1L9lQWx0s5nsbFUijezoZAuRFxz1ODY3td69mjvCB34wFsOMsKCaUNB67s47000oSqFJHx5rRjT7otn0IwAxREsDCZAitVQBpQZDZD"

# Check user permissions
# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token=EAAJXl0kUqRkBAAULA4V5eEKa7fWO8gasPUpMshLpPjjvFC5nS1MqOYZBWtfGYoK4wZAExDvsOV1ZAZA7oQhwPYjRzQoD1ZCvNn4QZC08nNZAmZBQEoUtHbHoz8ipJYxCDKWAGK0thAzrun9UUIoKecWmRIpPVwlSSnSq6AZCZA8Wq8zrizBanz9ixS&debug=all'
