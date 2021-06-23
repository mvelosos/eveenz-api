# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notifiable_type   :string           not null
#  notifiable_id     :bigint           not null
#  notification_type :string
#  viewed            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discarded_at      :datetime
#  account_id        :bigint           not null
#
FactoryBot.define do
  factory :notification do
    notifiable { nil }
    notification_type { "MyString" }
    viewed { false }
  end
end
