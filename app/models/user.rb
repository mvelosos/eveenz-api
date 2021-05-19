# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  email           :string
#  username        :string
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

  API_PROVIDER      = 'api'.freeze
  FACEBOOK_PROVIDER = 'facebook'.freeze
  GOOGLE_PROVIDER   = 'google'.freeze
  APPLE_PROVIDER    = 'apple'.freeze

  PROVIDERS = [
    API_PROVIDER,
    FACEBOOK_PROVIDER,
    GOOGLE_PROVIDER,
    APPLE_PROVIDER
  ].freeze

  has_one :account, dependent: :destroy
  has_one :password_recovery, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[a-zA-Z0-9_.]+\Z/ }
  validates :username, length: { minimum: 3, maximum: 25 }, allow_blank: false
  validates :email,    presence: true, uniqueness: true
  validates :email,    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :provider, presence: true
  validates :provider, inclusion: { in: PROVIDERS }

  validates_associated :account, on: :create

  before_save  :downcase_username
  after_update :password_successfully_updated_mailer, if: :saved_change_to_password_digest?

  private

  def downcase_username
    self.username = username.downcase if username.present?
  end

  def password_successfully_updated_mailer
    PasswordsMailer.password_successfully_updated(self).deliver_later
  end
end
