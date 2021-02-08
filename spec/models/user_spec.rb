# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  email           :string
#  username        :string
#  password_digest :string
#  uid             :string
#  provider        :string           default("api")
#  active          :boolean          default(TRUE)
#  verified        :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations and validations' do
    it { is_expected.to have_one :account }
    it { is_expected.to have_one :password_recovery }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to allow_value('foo_bar').for(:username) }
    it { is_expected.to allow_value('foo.bar').for(:username) }
    it { is_expected.to allow_value('foobar123').for(:username) }
    it { is_expected.to_not allow_value('foo@bar').for(:username) }
    it { is_expected.to validate_length_of(:username).is_at_least(3).is_at_most(25) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('foo@bar.com').for(:email) }
    it { is_expected.to_not allow_value('foobar.com').for(:email) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_inclusion_of(:provider).in_array(User::PROVIDERS) }
  end

  context 'custom validations' do
    it 'expect user to have a uuid' do
      user = FactoryBot.create(:user).reload
      expect(user.uuid).to_not be_nil
      expect(user.uuid).to_not be_blank
    end
  end
end
