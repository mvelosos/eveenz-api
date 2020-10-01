# User Factory
FactoryBot.define do
  factory :user do
    username { Faker::Lorem.word }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password }
  end
end
