class AddressSerializer < ActiveModel::Serializer
  attributes :street, :number, :complement, :neighborhood, :zip_code, :city, :state, :country
end
