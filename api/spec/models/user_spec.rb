# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'create' do
    it 'all params is valid' do
      expect(user).to be_valid
    end

    context 'when params is validate' do
      let(:user) { create(:user) }

      it 'presence of email' do
        expect(user).to be_valid
      end

      it 'uniqueness of email' do
        expect(user).to be_valid
      end
    end
  end

  describe 'methods and functions' do 
    it '#generete_passworld_token!' do
      user.generate_password_token!
      expect(user.valid?).to eq(true)
    end

    it '#password_token_valid?' do
      user.generate_password_token!
      user.password_token_valid?
      expect(user.valid?).to eq(true)
    end

    it '#reset_password! whit params' do
      user.generate_password_token!
      user.password_token_valid?
      user.password = 'GN&03i4686#Z'
      user.password_confirmation = 'GN&03i4686#Z'
      user.reset_password!('GN&03i4686#Z')
      expect(user.valid?).to eq(true)
    end
  end
end
