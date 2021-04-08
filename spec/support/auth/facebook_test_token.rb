module Auth
  module FacebookTestToken
    def retrieve_facebook_test_token
      client_id = '659257231190297'
      client_secret = '7e8fde7f90333cf761f109e9e5a78d91'
      token = 'EAAJXl0kUqRkBAL4qqtrfMyhW9D7JSprdBUbOPf7RyIVMCE15UB5EIKpclBveiEdfco2G6MfaEnE9NFHcXH0dexsiYFkxGS9a75QIR'\
              'i3AocB6ZCiba0BLqhrpCPdBTXI20PlGxZBbmLwMvm6nnEZC9QApo7k7udtg9X2lfvi5AhaEj7jREY2'

      url = "https://graph.facebook.com/v9.0/oauth/access_token?grant_type=fb_exchange_token&client_id=#{client_id}"\
            "&client_secret=#{client_secret}&fb_exchange_token=#{token}&auth_type=reauthorize"

      response = Faraday.get(url)
      JSON(response.body)['access_token']
    end
  end
end

# curl -i -X GET "https://graph.facebook.com/v10.0/oauth/access_token?grant_type=fb_exchange_token&client_id=659257231190297&client_secret=7e8fde7f90333cf761f109e9e5a78d91&fb_exchange_token=EAAJXl0kUqRkBAO0a4nCyPmjdrBZCSBzfr74tROpfISmMdC65xvVM4ZBZCEZBnFRBOguhFS8ZANmYLwrWhuCMNmXBeJdTD4JEvz3IyBLeOi51pcEEbNwdOASQ8bAZBSpEnMmQ8yPQSn8wM5IUZASYeeaQCdHgU5m8Iyx6Q841bI63l2cZB2l9qXnfuB6rzrT8Ma602xAQTStf3AZDZD"

# curl -i -X GET 'https://graph.facebook.com/me/permissions?access_token=EAAJXl0kUqRkBAAESszHXeZAXZCZAgZAP4ZBsZCETlT1CoTPhKqbtQj866OVe6VSM0d44sFHUJCuR0GJzMTGhq61AP3qvn8mRPikhQ0i4ZCZBX5S2lXpseTkLfzMJV9JFl20sCbgdN1ZB1KxIBT3eacZCZBJVCXmDsYiw7iR05wTVsi32MBnr22ZAZBxAv&debug=all'
