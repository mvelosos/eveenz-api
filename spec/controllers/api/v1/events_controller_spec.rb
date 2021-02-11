require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)
    @localization = @current_user.account.localization
    @events = FactoryBot.create_list(:event, 10)
    authenticate_user_for_api(@current_user)
  end

  describe 'GET #index' do
    context 'when events exists' do
      before do
        @events.each do |event|
          event.localization = FactoryBot.create(:localization,
                                                 localizable: event,
                                                 latitude: @localization.latitude + 0.001,
                                                 longitude: @localization.longitude + 0.001)
        end
      end

      it 'should return a list of events' do
        get :index
        expect(json).to have_key('events')
        expect(json['events'].count).to eq(10)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when events do not exists' do
      it 'should return an empty array' do
        get :index
        expect(json).to have_key('events')
        expect(json['events']).to be_empty
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    before do
      @event_params = {
        event: {
          name: Faker::Company.bs,
          description: Faker::Lorem.sentence(word_count: 6),
          startDate: Date.today,
          startTime: Time.current,
          privacy: 'public',
          addressAttributes: {
            street: Faker::Address.street_name,
            number: Faker::Number.number(digits: 4),
            neighborhood: Faker::Address.community,
            city: Faker::Address.city,
            state: Faker::Address.state,
            country: Faker::Address.country,
            zipCode: Faker::Address.zip_code
          },
          localizationAttributes: {
            latitude: Faker::Address.latitude,
            longitude: Faker::Address.longitude
          }
        }
      }
    end

    context 'with valid params' do
      it 'should create an event' do
        post :create, params: @event_params
        expect(json).to have_key('event')
        expect(json['event']['uuid']).to_not be_nil
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'with invalid name' do
        post :create, params: @event_params.deep_merge(event: { name: nil })
        expect(json).to have_key('errors')
        expect(json['errors']).to_not be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with invalid start date' do
        post :create, params: @event_params.deep_merge(event: { startDate: nil })
        expect(json).to have_key('errors')
        expect(json['errors']).to_not be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'with invalid start time' do
        post :create, params: @event_params.deep_merge(event: { startTime: nil })
        expect(json).to have_key('errors')
        expect(json['errors']).to_not be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
