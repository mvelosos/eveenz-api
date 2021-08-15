# == Schema Information
#
# Table name: request_follows
#
#  id              :bigint           not null, primary key
#  requested_by_id :bigint           not null
#  account_id      :bigint           not null
#  accepted        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe RequestFollow, type: :model do
  describe 'associations and validations' do
    it { is_expected.to belong_to :requested_by }
    it { is_expected.to belong_to :account }
  end
end
