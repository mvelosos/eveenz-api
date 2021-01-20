# == Schema Information
#
# Table name: account_settings
#
#  id              :bigint           not null, primary key
#  account_id      :bigint
#  distance_radius :float            default(10.0), not null
#  unit            :string           default("km"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#

require 'rails_helper'

RSpec.describe AccountSetting, type: :model do
  context 'associations and validations' do
    it { is_expected.to belong_to :account }

    it { is_expected.to validate_presence_of(:distance_radius) }
    it { is_expected.to validate_presence_of(:unit) }
    it { should validate_inclusion_of(:unit).in_array(%w(km mi)) }
  end
end
