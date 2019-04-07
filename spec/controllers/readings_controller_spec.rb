# frozen_string_literal: true

# rubocop:disable  Metrics/BlockLength
require 'rails_helper'

RSpec.describe ReadingsController do
  let(:session) { create(:session) }
  let(:reading) { create(:reading, session_id: session.id) }
  let(:reading_two) { build(:reading, session_id: session.id, number: 2) }
  let(:reading_three) { build(:reading, session_id: session.id, number: 3) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  before(:each) do
    @reading_hash = reading.attributes.to_hash
    @reading_params = { id: reading.id, reading: @reading_hash }
  end

  describe 'bulk update and create' do
    before(:each) do
      sign_in admin

      @reading2_hash = reading_two.attributes.to_hash
      @reading3_hash = reading_three.attributes.to_hash

      @new_reading_params = { session: { id: reading.session_id }, reading:
                              { readings: [@reading2_hash] } }

      @new_readings_params = { session: { id: reading.session_id }, reading:
                             { readings: [@reading3_hash, @reading2_hash] } }
    end

    it 'creates a new reading' do
      expect(Reading.count).to eq(1)

      post :create, params: @new_reading_params, format: 'json'

      expect(Reading.count).to eq(2)
      body = JSON.parse(response.body)
      expect(body.last['readings']).to eq(reading_two[:readings])
      expect(response.status).to eq(201)
    end

    it 'creates new readings' do
      expect(Reading.count).to be(1)

      post :create, params: @new_readings_params, format: 'json'

      expect(response.status).to eq(201)
      expect(assigns(:readings)).to_not be(nil)
      expect(JSON.parse(response.body).count).to be(2)
      expect(Reading.count).to be(3)
      expect(JSON.parse(response.body).last['readings']).to eq(reading_two[:readings])
      expect(Reading.last.readings).to eq(reading_two[:readings])
    end

    it 'updates a reading' do
      @reading2_hash['readings'] = %w[3 5].to_json
      @new_readings_params = { session: { id: reading.session_id }, reading:
                              { readings: [@reading_hash, @reading2_hash] } }
      expect(Reading).to receive(:where).and_return([reading, reading_two])
      expect(Reading.first.readings).to eq(%w[1 2].to_json)
      expect(Reading.last.readings).to eq(%w[1 2].to_json)

      post :create, params: @new_readings_params, format: 'json'

      expect(response.status).to eq(201)
      expect(assigns(:readings)).to eq([reading, reading_two])
      expect(JSON.parse(response.body).first['readings']).to eq(%w[1 2].to_json)
      expect(JSON.parse(response.body).last['readings']).to eq(%w[3 5].to_json)
      expect(Reading.first.readings).to eq(%w[1 2].to_json)
      expect(Reading.last.readings).to eq(%w[3 5].to_json)
    end

    it 'updates many readings' do
      reading_two[:number] = '2'
      @reading1 = {
        session_id: reading.session_id,
        number: reading.number,
        readings: %w[10].to_json
      }
      @reading2 = {
        session_id: reading.session_id,
        number: '2',
        readings: %w[3 5].to_json
      }
      @new_readings_params = { session: { id: reading.session_id }, reading:
                              { readings: [@reading1, @reading2] } }
      expect(Reading).to receive(:where).and_return([reading, reading_two])
      expect(Reading.first.readings).to eq(%w[1 2].to_json)
      expect(Reading.last.readings).to eq(%w[1 2].to_json)

      post :create, params: @new_readings_params, format: 'json'

      expect(response.status).to eq(201)
      expect(assigns(:readings)).to eq([reading, reading_two])
      expect(JSON.parse(response.body).first['readings']).to eq(%w[10].to_json)
      expect(JSON.parse(response.body).last['readings']).to eq(%w[3 5].to_json)
      expect(Reading.first.readings).to eq(%w[10].to_json)
      expect(Reading.last.readings).to eq(%w[3 5].to_json)
    end
  end

  describe 'admin user' do
    before(:each) do
      sign_in admin
      @reading_with_session_params = { session: { session_id: 1 }, reading:
                          { readings: [id: '1',
                                       number: '1',
                                       readings: %w[1 2]] } }
    end

    it 'does allow create' do
      expect(Reading).to receive(:where).and_return([reading])
      post :create, params: @reading_with_session_params, format: 'json'
      expect(response.status).to eq(201)
    end

    it 'does allow destroy' do
      delete :destroy, params: @reading_params

      expect(response).to have_http_status(302)
    end

    it 'does allow update' do
      patch :update, params: @reading_params
      expect(response).to have_http_status(302)

      put :update, params: @reading_params
      expect(response).to have_http_status(302)
    end

    it 'does allow edit' do
      get :edit, params: @reading_params
      expect(response).to have_http_status(200)
    end

    it 'does allow new' do
      get :new
      expect(response).to have_http_status(200)
    end

    it 'does allow new' do
      get :new
      expect(response).to have_http_status(200)
    end

    it 'does allow update' do
      patch :update, params: @reading_params
      expect(response).to have_http_status(302)

      put :update, params: @reading_params
      expect(response).to have_http_status(302)
    end
  end

  describe 'normal user' do
    before(:each) do
      sign_in user
    end
    it 'does allow index' do
      expect(Reading).to receive(:where).and_return(reading)
      get :index
      expect(assigns(:readings)).to eq(reading)
      expect(response.status).to eq(200)
    end

    it 'does allow show' do
      expect(Reading).to receive(:find).and_return(reading)
      get :show, params: { id: '1' }
      expect(assigns(:reading)).to eq(reading)
      expect(response.status).to eq(200)
    end

    it 'does not allow destroy' do
      delete :destroy, params: @reading_params
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it 'does not allow update' do
      patch :update, params: @reading_params
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)

      put :update, params: @reading_params
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it 'does not allow edit' do
      get :edit, params: @reading_params
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it 'does not allow new' do
      get :new
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it 'does not allow create' do
      post :create, params: @reading_params
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'anonymous user' do
    before(:each) do
      sign_out user
    end
    it 'does allow index' do
      expect(Reading).to receive(:where).and_return(reading)
      get :index
      expect(assigns(:readings)).to eq(reading)
      expect(response.status).to eq(200)
    end

    it 'does allow show' do
      expect(Reading).to receive(:find).and_return(reading)
      get :show, params: { id: '1' }
      expect(assigns(:reading)).to eq(reading)
      expect(response.status).to eq(200)
    end

    it 'does not allow destroy' do
      delete :destroy, params: { id: '1' }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'does not allow update' do
      patch :update, params: { id: '1' }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)

      put :update, params: { id: '1' }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'does not allow edit' do
      get :edit, params: { id: '1' }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'does not allow new' do
      get :new
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'does not allow create' do
      post :create
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
