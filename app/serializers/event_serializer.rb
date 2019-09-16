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

  attributes :id, :name, :description, :images, :address, :localization, :distance, :kind, :date, :time, :host_avatar, :host_name

  def images
    images = []
    object.images.each do |image|
      images << rails_blob_url(image)
    end
    images
  end

  def distance
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
