# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  name         :string
#  bio          :text
#  popularity   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
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
