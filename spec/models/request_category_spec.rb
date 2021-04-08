# == Schema Information
#
# Table name: request_categories
#
#  id              :bigint           not null, primary key
#  requested_by_id :bigint
#  name            :string
#  approved        :boolean
#  approved_by_id  :bigint
#  approved_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#
require 'rails_helper'

RSpec.describe RequestCategory, type: :model do
  describe 'associations and validations' do
    it { is_expected.to belong_to :requested_by }
    it { is_expected.to belong_to(:approved_by).optional }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:requested_by) }
  end
end
