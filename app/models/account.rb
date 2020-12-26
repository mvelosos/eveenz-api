# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  name         :string
#  bio          :text
#  popularity   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

class Account < ApplicationRecord
  include Discard::Model

  searchkick

  belongs_to :user

  has_one_base64_attached :avatar, dependent: :destroy

  has_one    :account_setting,  dependent: :destroy
  has_one    :address,          as:  :addressable, dependent: :destroy
  has_one    :localization,     as:  :localizable, dependent: :destroy
  has_many   :events,           dependent: :destroy

  accepts_nested_attributes_for :address,      update_only: true
  accepts_nested_attributes_for :localization, update_only: true

  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z0-9_.]+\Z/ }
  validates :username, length: { minimum: 3, maximum: 25 }, allow_blank: false
  validates :name, length: { minimum: 0, maximum: 60 }, allow_blank: true
  validates :bio,  length: { minimum: 0, maximum: 500 }, allow_blank: true

  validates_associated :address,         on: :create
  validates_associated :localization,    on: :create
  validates_associated :account_setting, on: :create

  after_create :set_default_avatar

  acts_as_follower
  acts_as_followable

  def search_data
    { username: username, name: name }
  end

  def set_default_avatar
    avatar.attach(io: File.open('./app/assets/images/default_avatar.png'), filename: 'default_avatar.png')
  end
end
