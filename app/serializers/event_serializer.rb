# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  uuid          :uuid             not null
#  account_id    :bigint
#  name          :string
#  description   :text
#  active        :boolean          default(TRUE)
#  privacy       :string
#  start_date    :date
#  end_date      :date
#  start_time    :time
#  end_time      :time
#  undefined_end :boolean          default(FALSE)
#  external_url  :string
#  minimum_age   :integer
#  tags          :text             default([]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  discarded_at  :datetime
#

class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :uuid,
             :name,
             :description,
             :images,
             :distance,
             :privacy,
             :start_date,
             :end_date,
             :start_time,
             :end_time,
             :undefined_end,
             :external_url,
             :minimum_age,
             :host_avatar,
             :host_name

  has_one :address, serializer: AddressSerializer
  has_one :localization, serializer: LocalizationSerializer

  def images
    images = []
    object.images.each do |image|
      images << rails_blob_url(image)
    end
    images
  end

  def distance
    account = scope.account
    unit    = account.account_setting.unit

    distance = Haversine.distance(account.localization.latitude,
                                  account.localization.longitude,
                                  object.localization.latitude,
                                  object.localization.longitude)

    unit == 'km' ? "#{distance.to_km.ceil(2)}km" : "#{distance.to_mi.ceil(2)}mi"
  end

  def host_avatar
    rails_blob_url(object.account.avatar)
  end

  def host_name
    object.account.name
  end
end
