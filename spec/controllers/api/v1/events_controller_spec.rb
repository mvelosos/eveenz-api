require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)
    @localization = @current_user.account.localization
    @events = FactoryBot.create_list(:event, 10)
    @category = FactoryBot.create(:category)

    @event_params = {
      event: {
        name: Faker::Company.bs,
        description: Faker::Lorem.sentence(word_count: 6),
        startDate: Date.today,
        startTime: Time.current,
        endDate: Date.today + 1.day,
        endTime: Time.current + 24.hours,
        undefinedEnd: false,
        privacy: 'public',
        externalUrl: nil,
        minimumAge: nil,
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
        },
        eventCategoriesAttributes: [
          {
            categoryId: @category.id
          }
        ]
      }
    }

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
    context 'with valid params' do
      it 'should create an event' do
        post :create, params: @event_params
        expect(json).to have_key('event')
        expect(json['event']['uuid']).to_not be_nil
        expect(response).to have_http_status(:created)
      end

      it 'should create event_category associations' do
        post :create, params: @event_params
        expect(Event.find_by_uuid(json['event']['uuid']).categories.count).to eq(1)
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

    context 'with undefinedEnd = false' do
      it 'should successfuly create an event when end_date and end_time is valid' do
        post :create, params: @event_params
        expect(json).to have_key('event')
        expect(json['event']['uuid']).to_not be_nil
        expect(response).to have_http_status(:created)
        expect(Event.find_by_uuid(json['event']['uuid']).end_date).to_not be_nil
        expect(Event.find_by_uuid(json['event']['uuid']).end_time).to_not be_nil
      end

      it 'should not create an event when end_date and end_time is nil' do
        post :create, params: @event_params.deep_merge(event: { endDate: nil, endTime: nil })
        expect(json).to have_key('errors')
        expect(json['errors']).to_not be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with undefinedEnd = true' do
      it 'should successfuly create an event when end_date and end_time is nil' do
        post :create, params: @event_params.deep_merge(event: { endDate: nil, endTime: nil, undefinedEnd: true })
        expect(json).to have_key('event')
        expect(json['event']['uuid']).to_not be_nil
        expect(response).to have_http_status(:created)
        expect(Event.find_by_uuid(json['event']['uuid']).end_date).to be_nil
        expect(Event.find_by_uuid(json['event']['uuid']).end_time).to be_nil
      end
    end
  end

  describe 'PUT/PATCH #update' do
    context 'when user is not the creator of the event' do
      it 'should return unauthorized' do
        event = FactoryBot.create(:event).reload
        put :update, params: { uuid: event.uuid }
        expect(json['error']).to be_truthy
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is the creator of the event' do
      it 'with valid params should successfuly update the event' do
        event = FactoryBot.create(:event, account: @current_user.account).reload
        put :update, params: { uuid: event.uuid, event: @event_params[:event].deep_merge(name: 'foobar123') }
        expect(Event.find_by_uuid(json['event']['uuid']).name).to eq('foobar123')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is the creator of the event' do
      it 'requesting to destroy categories should destroy categories' do
        event = FactoryBot.create(:event, account: @current_user.account).reload
        event.event_categories << FactoryBot.create(:event_category)
        event_category_id = event.event_categories.first.id
        new_params = @event_params[:event].deep_merge(eventCategoriesAttributes: [{ id: event_category_id, _destroy: 1 }])
        put :update, params: { uuid: event.uuid, event: new_params }
        expect(Event.find_by_uuid(json['event']['uuid']).event_categories.count).to eq(0)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
