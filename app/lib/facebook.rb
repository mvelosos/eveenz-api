class Facebook
  @fields = %w[id name email picture]

  def self.client(access_token)
    Koala::Facebook::API.new(access_token)
  end

  def self.info(access_token)
    client(access_token).get_object('me', { fields: @fields })
  end
end
