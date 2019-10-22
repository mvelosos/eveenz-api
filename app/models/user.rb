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

class User < ApplicationRecord
  has_secure_password

  has_one :account, dependent: :destroy

  validates :email,     presence: true, uniqueness: true
  validates :email,     format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username,  presence: true, uniqueness: true
  validates :username,  format: { with: /\A[a-zA-Z0-9_.]+\Z/ }
  validates :username,  length: { minimum: 3, maximum: 25 }, allow_blank: false
  validates :password,  length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  validates_associated :account, on: :create

  before_create :build_associations, if: -> { new_record? }

  def build_associations
    self.build_account
    self.account.build_account_setting
    self.account.build_address
    self.account.build_localization
  end
end
