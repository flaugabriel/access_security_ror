# frozen_string_literal: true

require 'rails_helper'
include ActionController::RespondWith

RSpec.describe 'Api::V1::MyaccountController', type: :request do
  let(:current_user) { create(:user) }

  describe 'GET #profile' do
    context 'when return the current_user profile' do
      before do
        login(current_user)
      end

      it 'gives you a status 200 on signing in ' do
        expect(response.status).to eq(200)
      end

      it 'when return the user profile' do
        expect(response.status).to eq(200)
        expect(json['data']['email']).to eq(current_user.email)
      end
    end
  end

  describe 'GET #update' do
    context 'when update account whit correct params' do
      before do
        login(current_user)
      end

      it 'gives you a status 200 on update' do
        user_params = { user: {
          email: 'falugabriel@gmail.com',
          password: '321654987',
          password_confirmation: '321654987'
        } }

        api_my_account_profile_update_path(user_params)
        expect(response.status).to eq(200)
      end

      it 'when return error some password is wrong' do
        user_params = { user: {
          email: 'falugabriel@gmail.com',
          password: '1',
          password_confirmation: '654'
        } }
        put api_my_account_profile_update_path(user_params)
        user = JSON.parse(response.body)

        expect(response.status).to eq(401)
        expect(user['errors'].present?).to eq(true)
      end
    end
  end

  def login(current_user)
    post '/api/auth/sign_in', params: { email: current_user.email, password: current_user.password }
  end
end
