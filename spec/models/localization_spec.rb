# == Schema Information
#
# Table name: localizations
#
#  id               :bigint           not null, primary key
#  localizable_type :string
#  localizable_id   :bigint
#  latitude         :decimal(11, 8)
#  longitude        :decimal(11, 8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  discarded_at     :datetime
#

require 'rails_helper'

RSpec.describe Localization, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :localizable }
  end

  context 'custom validations' do
    context 'when localizable is an event' do
      subject { FactoryBot.build(:event_localization) }
      it { is_expected.to validate_presence_of(:latitude) }
      it { is_expected.to validate_presence_of(:longitude) }
    end
  end
end
