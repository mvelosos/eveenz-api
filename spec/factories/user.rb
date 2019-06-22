# User Factory
FactoryBot.define do
  factory :user do
    username { FFaker::Lorem.word }
    email  { FFaker::Internet.free_email }
    password { FFaker::Internet.password }
  end
end