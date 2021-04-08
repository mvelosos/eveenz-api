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
FactoryBot.define do
  factory :request_category do
    requested_by_id { FactoryBot.create(:account) }
    name { SecureRandom.hex(16) }
    approved { nil }
    approved_by_id { FactoryBot.create(:account) }
    approved_at { nil }
    discarded_at { nil }
  end
end
