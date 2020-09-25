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

class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  has_one :address, serializer: AddressSerializer
  has_one :localization, serializer: LocalizationSerializer

  attributes :type, :uuid, :id, :name, :description, :images, :address, :localization, :distance, :kind, :date, :time, :host_avatar, :host_name

  def type
    'event'
  end

  def uuid
    SecureRandom.uuid
  end

  def images
    images = []
    object.images.each do |image|
      images << rails_blob_url(image)
    end
    images
  end

  def distance
    account = instance_options[:current_user].account
    unit    = account.account_setting.unit

    distance = Haversine.distance(account.localization.latitude,
                                  account.localization.longitude,
                                  object.localization.latitude,
                                  object.localization.longitude)

    unit == 'km' ? "#{distance.to_km.ceil(2)}km" : "#{distance.to_mi.ceil(2)}mi"
  end

  def date
    object.date.strftime('%d/%m/%Y')
  end

  def time
    object.time.strftime('%H:%M')
  end

  def host_avatar
    rails_blob_url(object.account.avatar)
  end

  def host_name
    object.account.name
  end
end
