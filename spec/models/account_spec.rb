# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  name         :string
#  bio          :text
#  popularity   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'associations and validations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_one :account_setting }
    it { is_expected.to have_one :address }
    it { is_expected.to have_one :localization }
    it { is_expected.to have_many :events }
    it { is_expected.to have_many :notifications }
    it { is_expected.to have_one_attached :avatar }

    it { is_expected.to accept_nested_attributes_for(:address).update_only(true) }
    it { is_expected.to accept_nested_attributes_for(:localization).update_only(true) }

    it { is_expected.to validate_length_of(:name).is_at_least(0).is_at_most(30).allow_blank }
    it { is_expected.to validate_length_of(:bio).is_at_least(0).is_at_most(150).allow_blank }
  end

  context 'callbacks' do
    context '#after_create' do
      it 'set_default_avatar' do
        account = FactoryBot.create(:user).account
        expect(account.avatar.attached?).to be(true)
      end
    end
  end
end
