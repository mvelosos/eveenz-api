# == Schema Information
#
# Table name: event_categories
#
#  id          :bigint           not null, primary key
#  event_id    :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe EventCategory, type: :model do
  describe 'associations and validations' do
    it { is_expected.to validate_presence_of(:event) }
    it { is_expected.to validate_presence_of(:category) }
  end
end
