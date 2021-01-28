# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  email           :string
#  username        :string
#  password_digest :string
#  uid             :string
#  provider        :string           default("api")
#  active          :boolean          default(TRUE)
#  verified        :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    username { Faker::Internet.username(specifier: 5..24) }
    password { Faker::Internet.password }
    provider { 'api' }
  end
end
