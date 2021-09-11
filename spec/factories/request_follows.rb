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
FactoryBot.define do
  factory :request_follow do
    requested_by { FactoryBot.create(:user).account }
    account { FactoryBot.create(:user).account }
    accepted { nil }
  end
end
