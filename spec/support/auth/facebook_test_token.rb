module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAMLk91xbxqJCNXu0ZBBsvkzkzMYOX1tyCs8RVQRn3YFuZA51zH3RbWSIaTFELKPdsH21FbENXFMN'\
              'IOU0Ek9b5sc2l9g8u6A8D67y9fcu8v0pHA5nKITu3lJpZCwMmI2ncvwlbGsM1RCZCrJm3ZAgxMqZAaDjj9fe0clRcW0XTg'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# curl -i -X GET "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBAA5ZCd9CqFgwhEe5ZAokqkEtFMlXR8FMyswO4m1I7MHWnLep9NxdqX9N1IgrW4OSsyDEg54e8GCL0EZAKipelj1sL6hqHIP58y2a1UMJYFZB9AZCxZAMIcLsjcO1hHrFaFRBRDvLUKFWHdZBqxdajPvt9Lcko6BiCZBVeZAeTL9WixszjELkkA2h2ZAMJDQ4hY1ag1ugAWNpL4"
