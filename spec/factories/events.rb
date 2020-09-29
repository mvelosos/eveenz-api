# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
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
    account { nil }
    name { 'MyString' }
    description { 'MyText' }
    status { false }
    kind { 'MyString' }
    date { '2019-08-24' }
    time { '2019-08-24 18:06:23' }
    tags { '' }
  end
end
