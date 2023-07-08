# frozen_string_literal: true

require 'rails_helper'
include ActionController::RespondWith

RSpec.describe Api::V1::CnabsController, type: :request do
  let(:cnab) { create(:cnab) }
  let(:cnabs) { create_list(:cnab, 50, user: cnab.user) }

  describe 'GET #index' do
    context 'when return list of cnabs based by current user' do
      before do
        login(cnabs.first.user)
      end

      it 'gives you a status 200' do
        @auth_params = get_auth_params_from_login_response_headers(response)
        get api_cnabs_path, headers: @auth_params
        expect(response.status).to eq(200)
      end

      it 'when return a list of 51 registers' do
        @auth_params =  get_auth_params_from_login_response_headers(response)
        get api_cnabs_path, headers: @auth_params

        expect(response.status).to eq(200)
        expect(json.length).to eq(51)
      end
    end
  end

  describe 'GET #import' do
    context 'when make upload the cnab file' do
      let(:file) do
        Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                     'attachers', 'cnab.txt'), 'txt/xml')
      end
      before do
        login(cnabs.first.user)
      end

      it 'gives you a status 200' do
        cnab_params = { file: }
        @auth_params =  get_auth_params_from_login_response_headers(response)
        post import_api_cnabs_path, params: cnab_params, headers: @auth_params
        expect(response.status).to eq(200)
      end

      it 'gives imported with sucess' do
        cnab_params = { file: }
        @auth_params =  get_auth_params_from_login_response_headers(response)
        post import_api_cnabs_path, params: cnab_params, headers: @auth_params
        expect(json['status']).to eq(true)
        expect(json['message']).to eq('CNAB importada com sucesso!')
      end

      it 'gives not imported cause not send any file' do
        cnab_params = { file: '' }
        @auth_params =  get_auth_params_from_login_response_headers(response)
        post import_api_cnabs_path, params: cnab_params, headers: @auth_params
        expect(json['message']).to eq('Nenhum arquivo carregado!')
      end
    end
  end

  describe 'GET #delete_all' do
    context 'when all cnabs of current user is deleted' do
      before do
        login(cnab.user)
      end

      it 'gives you a status 200' do
        @auth_params = get_auth_params_from_login_response_headers(response)
        delete api_cnabs_path, headers: @auth_params
        expect(response.status).to eq(200)
      end

      it 'gives you a 1 number of list of cnabs' do
        @auth_params =  get_auth_params_from_login_response_headers(response)
        delete api_cnabs_path, headers: @auth_params
        expect(json.length).to eq(1)
      end
    end
  end
end
