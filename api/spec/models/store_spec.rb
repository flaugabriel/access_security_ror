# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:store) { create(:store) }

  it 'all params is valid' do
    expect(store).to be_valid
  end

  describe 'validate presence' do
    it 'validate_presence_of store_owner' do
      expect(store.store_owner.present?).to eq(true)
    end

    it 'validate_presence_of cpf' do
      expect(store.cpf.present?).to eq(true)
    end

    it 'validate_presence_of store_name' do
      expect(store.store_name.present?).to eq(true)
    end

    it 'validate_presence_of balance_total' do
      expect(store.balance_total.present?).to eq(true)
    end
  end
end
