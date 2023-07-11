# frozen_string_literal: true
# :nocov:

require 'rails_helper'
include ActionController::RespondWith

RSpec.describe Api::V1::MyaccountController, type: :request do
  let(:current_user) { create(:user) }

  describe "GET #profile" do
    before do
      login(current_user)
    end

    context "when show profile" do
      it "behaves like" do
        get api_myaccount_profile_path

          
          binding.pry
      end
    end
  end
  
  describe 'GET #update' do
    context 'when update account whit correct params' do
      before do
        api_user_session_path(current_user)
      end
      
      it 'gives you a status 200 on update and messager' do
        
        user_params = { user: {
          email: 'falugabriel@gmail.com',
          password: '123456789123456789',
          password_confirmation: '123456789123456789'
        } }

        put api_my_account_profile_update_path(user_params)
        
        # expect(User.new(user_params[:user]).valid?).to eq(true)
        # expect(response.status).to eq(200)
        # expect(response.message).to eq('OK')
        # expect(json).to eq(200)
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
