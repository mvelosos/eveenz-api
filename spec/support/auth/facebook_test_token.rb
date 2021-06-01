module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAHCMiCh99oDtuyMTmd78bnY7RjVCJz5gJyOQbUwSRmJ9fpTZB1ix6JNMk8jqNcpnqwXtZBacKM90OwSjZCparPcpr6tb'\
              'kyV3ioJKncilztN2Secoj9upzZAwkNYb9lfH9B9HlDFjZA8TehJZBqL4V96Dg50W2s7lOEW28SHHWH'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# Get long live auth_token
# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBAC4hqsIIh1sizOs9SaTpE7F1LLxdhAXcQdZB2VbLpVZCiFiURA6W79Koc8txknzZAJmviaFTVXOfZAaFRZCk0ezLEeXKdxCOTQ238gxXwx1klei6GddA2krEMiWCjubkqSos89JS7ZAZBxGYprYNxHrHvcCwryXk4JdBzPATEzs10Rof78C4aNAeOdBvF4nfAZDZD"

# Check user permissions
# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token=EAAJXl0kUqRkBAC7sESmuzbNojLdWPKwHqoYMor7QJFGmovdZClspipcPwcl2VDthKTGFEtRCQ1sJmmvfnfRc7IZAZAfS5gbLiJAfD9BtpDLrPLnZCTW6ix0k4Of336NSHsthLzjchW8NwPEaZCQ4u1MTui8AZBNynI4cxegPDIm1XfmgJfCvmC&debug=all'
