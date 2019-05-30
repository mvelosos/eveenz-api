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
#  provider        :string
#  active          :boolean          default(TRUE)
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :created_at
end
