# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  account_id  :bigint
#  name        :string
#  description :text
#  active      :boolean          default(TRUE)
#  kind        :string
#  date        :date
#  time        :time
#  tags        :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
  searchkick

  belongs_to :account

  has_one    :address,      as: :addressable, dependent: :destroy
  has_one    :localization, as: :localizable, dependent: :destroy

  accepts_nested_attributes_for :address,      allow_destroy: true
  accepts_nested_attributes_for :localization, allow_destroy: true

  has_many_attached :images

  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true

  acts_as_followable

  scope :find_near_by, ->(user_latitude, user_longitude, distance_radius, unit) {
    unit_value = unit == 'km' ? 6371 : 3959

    haversine = "(#{unit_value} * acos(cos(radians(#{user_latitude}))
                * cos(radians(localizations.latitude))
                * cos(radians(localizations.longitude)
                - radians(#{user_longitude}))
                + sin(radians(#{user_latitude}))
                * sin(radians(localizations.latitude))))"

    joins(:localization)
    .select("events.*, #{haversine} as distance")
    .where("#{haversine} <= ?", distance_radius)
  }

  def search_data
    { name: name }
  end

end
