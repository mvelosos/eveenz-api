require 'rails_helper'

RSpec.describe UserRecoveryPasswordJob, type: :job do
  before do
    @user = FactoryBot.create(:user)
  end

  context '.perform' do
    it 'should create a password recovery for the user' do
      UserRecoveryPasswordJob.new.perform(@user.id)
      expect(@user.password_recovery.present?).to eq(true)
    end

    it 'should trigger #send_recovery_code from PasswordsMailer' do
      UserRecoveryPasswordJob.new.perform(@user.id)
      expect { PasswordsMailer.send_recovery_code(@user).deliver_later }.to have_enqueued_job.on_queue('mailers')
                                                                                             .with('PasswordsMailer',
                                                                                                   'send_recovery_code',
                                                                                                   'deliver_now',
                                                                                                   @user)
    end
  end
end
