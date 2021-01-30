# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  account_id   :bigint
#  name         :string
#  description  :text
#  active       :boolean          default(TRUE)
#  kind         :string
#  date         :date
#  time         :time
#  tags         :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

FactoryBot.define do
  factory :event do
    account { FactoryBot.create(:user).account }
    name { Faker::Company.bs }
    description { Faker::Lorem.sentence(word_count: 6) }
    kind { 'public' }
    date { Date.today }
    time { Time.current }
    tags { {} }
  end
end
