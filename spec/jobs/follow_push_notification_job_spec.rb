require 'rails_helper'

RSpec.describe FollowPushNotificationJob, type: :job do
  describe '#perform_later' do
    before do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @follow = FactoryBot.create(:follow, followable: @user1.account, follower: @user2.account)
    end

    it 'send follow push notification' do
      expect { FollowPushNotificationJob.perform_later(@follow) }.to have_enqueued_job
        .with(@follow).on_queue('push_notifications')
    end
  end
end
