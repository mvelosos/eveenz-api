class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :kind, :date, :time
  has_one :localization, serializer: LocalizationSerializer

  # TODO: ADICIONAR METODO PARA RETORNAR AS IMAGES
end
