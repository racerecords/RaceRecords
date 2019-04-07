require 'rails_helper'

RSpec.describe ReadingsController do
  let(:reading) { create(:reading) }

  describe 'anonymous user' do
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
