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

RSpec.describe Address, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :addressable }
  end

  context 'custom addressable' do
    context 'when localizable is an event' do
      subject { FactoryBot.build(:event_address) }
      it { is_expected.to validate_presence_of(:street) }
      it { is_expected.to validate_presence_of(:number) }
      it { is_expected.to validate_presence_of(:neighborhood) }
      it { is_expected.to validate_presence_of(:zip_code) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:state) }
      it { is_expected.to validate_presence_of(:country) }
    end
  end
end
