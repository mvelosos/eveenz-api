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
#  kind         :string
#  date         :date
#  time         :time
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

    it { is_expected.to accept_nested_attributes_for(:address).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:localization).allow_destroy(true) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:time) }
  end

  context 'methods' do
    it 'search_data' do
      event = FactoryBot.create(:event)
      Event.reindex
      expect(Event.search(event.name)).to be_truthy
    end
  end
end
