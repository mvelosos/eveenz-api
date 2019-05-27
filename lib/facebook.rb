class Facebook
  
  @fields = ['id', 'name', 'email']

  def self.client(access_token)
    Koala::Facebook::API.new(access_token)
  end
  
  def self.info(access_token)
    client(access_token).get_object('me', {fields: @fields})
  end

end