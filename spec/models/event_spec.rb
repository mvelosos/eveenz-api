# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  account_id   :bigint
#  name         :string
#  description  :text
#  active       :boolean          default(TRUE)
#  privacy      :string
#  start_date   :date
#  end_date     :date
#  start_time   :time
#  end_time     :time
#  tags         :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'associations and validations' do
    it { is_expected.to belong_to :account }
    it { is_expected.to have_one :address }
    it { is_expected.to have_one :localization }
    it { is_expected.to have_many_attached :images }

    it { is_expected.to accept_nested_attributes_for(:address).update_only(true) }
    it { is_expected.to accept_nested_attributes_for(:localization).update_only(true) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:privacy) }
    it { is_expected.to validate_inclusion_of(:privacy).in_array(Event::PRIVACIES) }
  end

  context 'methods' do
    it 'search_data' do
      event = FactoryBot.create(:event)
      Event.reindex
      expect(Event.search(event.name)).to be_truthy
    end
  end
end
