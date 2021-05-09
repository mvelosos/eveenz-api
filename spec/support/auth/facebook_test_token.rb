module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAHRSJNHfQxjcKJolZA3osgfvgYgu1qpI4AZBpP11ZAscOgNhF47WsjxVTlDBwMZBuCa6EkzIDCRraXotgt1IdxWe'\
              'q0jh9ExbvvXNjX4SjBjTDSIADknQ5Hwph9PnRncEcUf3p9cXMNsMTZAtYKNs1tApkyxJ0NvZBL4nbM4wN5'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# Get long live auth_token
# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBADYeJfggZBY4xwBxkI7PgmsUq9xX4SlgRg84bUgWlQfu9ZAKU13ZBPwsqsfVQ89IvTAw9wczy6QowtUlyv4AX5FxpX4hEd2ZBTLCHPPSNUwmTHv1SpTWjcLvg85TI7GXwmQHb90gb498qCIjeJ8ZAVWzWsu2a9II4NaSQ4d7dbtXSZBtekeE9YoGmeKuRKVeJmBYnDHG9k"

# Check user permissions
# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token=EAAJXl0kUqRkBAAULA4V5eEKa7fWO8gasPUpMshLpPjjvFC5nS1MqOYZBWtfGYoK4wZAExDvsOV1ZAZA7oQhwPYjRzQoD1ZCvNn4QZC08nNZAmZBQEoUtHbHoz8ipJYxCDKWAGK0thAzrun9UUIoKecWmRIpPVwlSSnSq6AZCZA8Wq8zrizBanz9ixS&debug=all'
