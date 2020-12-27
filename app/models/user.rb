# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
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

class User < ApplicationRecord
  include Discard::Model

  has_secure_password

  has_one :account, dependent: :destroy

  validates :email,     presence: true, uniqueness: true
  validates :email,     format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,  length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  validates_associated :account, on: :create

  accepts_nested_attributes_for :account

  after_initialize :build_associations, if: -> { new_record? }

  def build_associations
    account.build_account_setting
    account.build_address
    account.build_localization
  end
end
