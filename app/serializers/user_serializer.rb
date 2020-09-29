# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  uid             :string
#  provider        :string           default("api")
#  active          :boolean          default(TRUE)
#  verified        :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#

class UserSerializer < ActiveModel::Serializer
  attributes :username, :email, :provider, :created_at
end
