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

class User < ApplicationRecord
  has_secure_password

  validates :email,     presence: true, uniqueness: true
  validates :email,     format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username,  presence: true, uniqueness: true
  validates :username,  format: { with: /\A[a-zA-Z0-9_.]+\Z/ }
  validates :password,  length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
