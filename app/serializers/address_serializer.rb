# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  addressable_id   :bigint
#  street           :string
#  number           :string
#  complement       :string
#  neighborhood     :string
#  zip_code         :string
#  city             :string
#  state            :string
#  country          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  discarded_at     :datetime
#

class AddressSerializer < ActiveModel::Serializer
  attributes :street,
             :number,
             :complement,
             :neighborhood,
             :zip_code,
             :city,
             :state,
             :country
end
