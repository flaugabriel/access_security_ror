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
end
