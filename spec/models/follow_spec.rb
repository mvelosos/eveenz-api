# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string           not null
#  followable_id   :bigint           not null
#  follower_type   :string           not null
#  follower_id     :bigint           not null
#  blocked         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Follow, type: :model do
  context 'associations and validations' do
    it { is_expected.to belong_to :followable }
    it { is_expected.to belong_to :follower }

    it { is_expected.to validate_presence_of(:followable_type) }
    it { is_expected.to validate_inclusion_of(:followable_type).in_array(Follow::ALLOWED_TYPES) }
    it { is_expected.to validate_presence_of(:follower_type) }
    it { is_expected.to validate_inclusion_of(:follower_type).in_array(Follow::ALLOWED_TYPES) }
  end

  context 'callbacks' do
    it '#account_follow_notification' do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @follow = FactoryBot.create(:follow, followable: @user1.account, follower: @user2.account)
      expect(Notification.where(account: @user1.account, notifiable: @user2.account)).to exist
      expect { FollowPushNotificationJob.perform_later(@follow) }.to have_enqueued_job
        .with(@follow).on_queue('push_notifications')
    end

    it '#destroy_account_follow_notification' do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @notification = FactoryBot.create(:notification, account: @user1.account, notifiable: @user2.account)
      expect(@notification.persisted?).to eq(true)

      @notification.destroy!
      expect(Notification.where(account: @user1.account, notifiable: @user2.account)).to be_empty
    end
  end

  context 'methods' do
    it 'block!' do
      follow = FactoryBot.create(:follow)
      follow.block!
      expect(follow.blocked).to be(true)
    end
  end
end
