module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAPFryLdVgIxiCdFpqhUsPvq3pZATGQdeBImau2zlCPvZCOThYXZCEUvzo5e7wxHipI5P0ZCrWsUPWv5YUcXe7r'\
              '5qH1VlfUuKAVwKDbZAi9AuXrtieeQmCa6CKdsiQ9w51oO02WVyG8gc20eSdAxUEb9cvYKTmm2GxOX2v5wWk'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# Get long live auth_token
# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBAMXua0TLZCLzXcSndFDhEDTjBPVImsR7cm6NSpOVJ3R9VzeS5lJhqWliMUSV3ZBffQbiBmDyuIWT2aAEX8cQq7uqJ5KG8MLiki71iIzCDNINZAoqdZCjsFftUefhEsBKOP2gLzOwoKcFrWRu0ZB88CwAmdBeYdo5XhWQumGihNgfb5RrRzYbnCBEZBttObtwZDZD"

# Check user permissions
# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token=EAAJXl0kUqRkBAMXua0TLZCLzXcSndFDhEDTjBPVImsR7cm6NSpOVJ3R9VzeS5lJhqWliMUSV3ZBffQbiBmDyuIWT2aAEX8cQq7uqJ5KG8MLiki71iIzCDNINZAoqdZCjsFftUefhEsBKOP2gLzOwoKcFrWRu0ZB88CwAmdBeYdo5XhWQumGihNgfb5RrRzYbnCBEZBttObtwZDZD&debug=all'
