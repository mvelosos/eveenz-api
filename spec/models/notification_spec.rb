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
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'associations and validations' do
    it { is_expected.to belong_to :notifiable }

    it { is_expected.to validate_presence_of(:notification_type) }
    it { is_expected.to validate_inclusion_of(:notification_type).in_array(Notification::NOTIFICATION_TYPES) }
  end
end
