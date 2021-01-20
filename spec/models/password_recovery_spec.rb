# == Schema Information
#
# Table name: password_recoveries
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  code         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#  token        :string
#
require 'rails_helper'

RSpec.describe PasswordRecovery, type: :model do
  context 'associations and validations' do
    subject { FactoryBot.build(:password_recovery, user: FactoryBot.create(:user)) }

    it { is_expected.to belong_to :user }

    it { is_expected.to validate_length_of(:code).is_at_least(6).is_at_most(6).on(:save) }
    it { is_expected.to validate_uniqueness_of(:token).allow_nil }
  end

  context 'callbacks' do
    context '#before_create' do
      it 'generate_recovery_code' do
        password_recovery = FactoryBot.build(:password_recovery)
        expect(password_recovery.code.present?).to be(true)
      end
    end
  end
end
