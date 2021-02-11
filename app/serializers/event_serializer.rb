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

class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :uuid,
             :name,
             :description,
             :images,
            #  :distance,
             :kind,
             :start_date,
             :end_date,
             :start_time,
             :end_time,
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
    account = instance_options[:account]
    unit    = account.account_setting.unit

    distance = Haversine.distance(account.localization.latitude,
                                  account.localization.longitude,
                                  object.localization.latitude,
                                  object.localization.longitude)

    unit == 'km' ? "#{distance.to_km.ceil(2)}km" : "#{distance.to_mi.ceil(2)}mi"
  end

  def start_date
    object.start_date.strftime('%d/%m/%Y')
  end

  def end_date
    object.end_date&.strftime('%d/%m/%Y')
  end

  def start_time
    object.start_time.strftime('%H:%M')
  end

  def end_time
    object.end_time&.strftime('%H:%M')
  end

  def host_avatar
    rails_blob_url(object.account.avatar)
  end

  def host_name
    object.account.name
  end
end
