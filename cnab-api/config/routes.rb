# frozen_string_literal: true

require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :cnabs do
        delete :index, on: :collection, action: :delete_all
        collection { post :import }
      end
      resources :stores
      resources :deals
      get '/myaccount/profile', to: 'myaccount#profile'
      put '/myaccount/profile', to: 'myaccount#update', as: 'my_account_profile_update'
    end

    # for another features
    scope module: :v2,
          constraints: ApiConstraints.new(version: 2, default: false) do
    end
  end
end
