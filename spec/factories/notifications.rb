# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  account_id        :bigint
#  notifiable_type   :string           not null
#  notifiable_id     :bigint           not null
#  notification_type :string
#  viewed            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discarded_at      :datetime
#
FactoryBot.define do
  factory :notification do
    account { FactoryBot.create(:user).account }
    notifiable { FactoryBot.create(:user).account }
    notification_type { Notification::FOLLOW_TYPE }
    viewed { false }
  end
end
