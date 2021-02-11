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
#  privateness  :string
#  start_date   :date
#  end_date     :date
#  start_time   :time
#  end_time     :time
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
    privateness { 'public' }
    start_date { Date.today }
    end_date { Date.today }
    start_time { Time.current }
    end_time { Time.current + 6.hours }
    tags { {} }
  end
end
