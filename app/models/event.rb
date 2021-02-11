# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  account_id   :bigint
#  name         :string
#  description  :text
#  active       :boolean          default(TRUE)
#  privateness  :string
#  start_date   :date
#  end_date     :date
#  start_time   :time
#  end_time     :time
#  tags         :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

class Event < ApplicationRecord
  include Discard::Model

  searchkick
  acts_as_followable

  belongs_to :account

  has_one    :address,      as: :addressable, dependent: :destroy
  has_one    :localization, as: :localizable, dependent: :destroy

  accepts_nested_attributes_for :address,      update_only: true
  accepts_nested_attributes_for :localization, update_only: true

  has_many_base64_attached :images

  validates :name,       presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true

  def search_data
    { name: name }
  end
end
