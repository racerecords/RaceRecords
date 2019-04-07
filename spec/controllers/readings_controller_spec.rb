require 'rails_helper'

RSpec.describe ReadingsController do
  let(:reading) { create(:reading) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  before(:each) do
    @reading_params = { id: reading.id, reading: { number: reading.number, car_class: reading.car_class, readings: reading.readings } }
  end


  describe 'admin user' do
    before(:each) do
      sign_in admin
    end

    it 'does allow create' do
      expect(Reading).to receive(:where).and_return([reading])
      post :create, params: { session: {session_id: 1}, reading: {readings: [id: '1', number: '1', readings: ['1','2']]} }, format: 'json'
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
