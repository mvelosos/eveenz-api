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
  end

  context 'callbacks' do
    it '#account_follow_notification' do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @follow = FactoryBot.create(:follow, followable: @user1, follower: @user2)
      expect { FollowPushNotificationJob.perform_later(@follow) }.to have_enqueued_job.with(@follow).on_queue('push_notifications')
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
