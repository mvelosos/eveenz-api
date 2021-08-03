module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAEIa8aFrEOtef7I1JcDeOnu3aW0CkZCyJ5smMv4TUAF8zvLsZC1L3H9mLqNZA9evZAkV28wRzkmJoeobZCBYZBGmdvy'\
              'igVDMCYkcCzyGNR6HVWPaNnk9RGrQDdHrBgJZAB1zPzBqzRXzy1rZAws2n7MYAN7mNPARTL9RrBkoFv5g'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# Get long live auth_token
# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBAKhTZBjcXFu5CZC6ot00eSVP426Wa0wnXhGYvfEmpWpRQ9xd9bADAdIyypB12tzfGjDvQ1IZCJNkGeaqTyI7va2sczpKZClB5JN0wvhVaqzJZCEfvNZCGFSrZBnAawGR7mjCpEc3LZCzeJepGddG9AQY4EgSZBcH2MoMbc0uzoEVA02ZB0bMPGJf0Ap9oHdOLUMgZDZD"

# Check user permissions
# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token=EAAJXl0kUqRkBAEIa8aFrEOtef7I1JcDeOnu3aW0CkZCyJ5smMv4TUAF8zvLsZC1L3H9mLqNZA9evZAkV28wRzkmJoeobZCBYZBGmdvyigVDMCYkcCzyGNR6HVWPaNnk9RGrQDdHrBgJZAB1zPzBqzRXzy1rZAws2n7MYAN7mNPARTL9RrBkoFv5g&debug=all'
