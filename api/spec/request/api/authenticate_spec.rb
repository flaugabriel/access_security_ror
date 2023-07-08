# frozen_string_literal: true

require 'rails_helper'
include ActionController::RespondWith

describe 'Whether access is ocurring properly', type: :request do
  let(:current_user) { create(:user) }

  context 'context: general authentication via API, ' do
    it 'gives you an authentication code if you are an existing user and you satisfy the password' do
      login current_user
      expect(response.has_header?('access-token')).to eq(true)
    end

    it 'gives you a status 200 on signing in ' do
      login current_user
      expect(response.status).to eq(200)
    end

    it 'gives you an authentication code if you are an existing user and you not satisfy the password' do
      current_user.password = '321654978'
      login current_user
      expect(response.has_header?('access-token')).to eq(false)
    end

    it 'gives you a status 401 on signing in ' do
      current_user.password = '321654978'
      login current_user
      expect(response.status).to eq(401)
    end
  end

  def login(current_user)
    post api_user_session_path, params: { email: current_user.email, password: current_user.password }.to_json,
                                headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end
end
