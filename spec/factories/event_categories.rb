# == Schema Information
#
# Table name: event_categories
#
#  id          :bigint           not null, primary key
#  event_id    :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :event_category do
    event { FactoryBot.create(:event) }
    category { FactoryBot.create(:category) }
  end
end
