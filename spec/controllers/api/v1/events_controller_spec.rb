require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)
    @localization = @current_user.account.localization
    @events = FactoryBot.create_list(:event, 10)
    @events.each do |event|
      event.localization = FactoryBot.create(:localization,
                                             localizable: event,
                                             latitude: @localization.latitude,
                                             longitude: @localization.longitude)
    end
    authenticate_user_for_api(@current_user)
  end

  describe 'GET #index' do
    context 'when events exists' do
      it 'should return a list of events' do
        get :index
        expect(json).to have_key('events')
        expect(json['events'].count).to eq(10)
      end
    end
  end
end
