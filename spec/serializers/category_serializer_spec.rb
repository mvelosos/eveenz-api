# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#
require 'rails_helper'

describe CategorySerializer, type: :serializer do
  before do
    @category = FactoryBot.create(:category)
  end

  let(:resource_key) { :category }
  let(:resource) { @category }

  let(:expected_fields) do
    %i[
      id
      name
      titleizedName
    ].sort
  end
end
