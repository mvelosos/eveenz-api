class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  has_one :address, serializer: AddressSerializer
  has_one :localization, serializer: LocalizationSerializer

  attributes :id, :name, :description, :images, :address, :localization, :distance, :kind, :date, :time, :host_avatar, :host_name

  def images
    []
  end

  def host_avatar
    rails_blob_url(object.account.avatar)
  end

  def host_name
    object.account.name
  end

  def distance
  end

end
