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
require 'rails_helper'

describe AddressSerializer, type: :serializer do
  before do
    @address = FactoryBot.create(:address, addressable: FactoryBot.create(:user).account)
  end

  let(:resource_key) { :address }
  let(:resource) { @address }

  let(:expected_fields) do
    %i[
      street
      number
      complement
      neighborhood
      zipCode
      city
      state
      country
    ].sort
  end
end
