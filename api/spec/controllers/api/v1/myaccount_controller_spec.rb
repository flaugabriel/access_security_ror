# frozen_string_literal: true
# :nocov:

require 'rails_helper'
include ActionController::RespondWith

RSpec.describe Api::V1::MyaccountController, type: :request do
  let(:auth_headers) { create(:user).create_new_auth_token }


  describe '#profile' do
    context "when get profile" do
      it "gives you a data and status 200" do
        get '/api/myaccount/profile', params: { }, headers: auth_headers

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['data'].class).to eq(Hash)
        expect(JSON.parse(response.body)['data']['email']).to eq(auth_headers['uid'])
      end
    end
  end

  describe 'GET #update' do
    context 'when update password whit correct params' do
      it 'gives you a status 200 on update and messager' do
        put '/api/myaccount/profile', params: 
        {
          user: { password: 'GN&03i4686#B', password_confirmation: 'GN&03i4686#B'}
        }, headers: auth_headers

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Senha atualizado, realize o login novamente!')
      end
    end

    context "when update password whit invalid params" do
      it 'gives error and status 422 and messager' do
        put '/api/myaccount/profile', params: 
        {
          user: { password: 'GN&03i4686#Z', password_confirmation: 'GN&03i4686#B'}
        }, headers: auth_headers

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('Password confirmation não é igual a Password')
      end
    end
  end

  describe 'GET #open_qrcode' do
    context 'load service class' do
      it 'gives QrcodeCreateService' do
        allow_any_instance_of(QrcodeCreateService).to receive(:build)
      end
    end
  end
end
