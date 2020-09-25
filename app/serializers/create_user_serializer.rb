# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  uid             :string
#  provider        :string           default("api")
#  active          :boolean          default(TRUE)
#

class CreateUserSerializer < ActiveModel::Serializer
  attributes :username, :created_at, :token, :type, :exp, :provider

  def token
    @instance_options[:token]
  end

  def type
    'Bearer'
  end

  def exp
    @instance_options[:time]
  end
end
