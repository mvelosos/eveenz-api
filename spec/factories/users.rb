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
    username { Faker::Alphanumeric.alphanumeric(number: 16) }
    password { Faker::Internet.password }
    provider { 'api' }

    after(:create) do |user|
      user.account = FactoryBot.create(:account, user: user)
      user.account.account_setting = FactoryBot.create(:account_setting, account: user.account)
      user.account.address = FactoryBot.create(:address, addressable: user.account)
      user.account.localization = FactoryBot.create(:localization, localizable: user.account)
    end
  end
end
