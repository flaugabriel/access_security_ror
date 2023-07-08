# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cnab, type: :model do
  let(:cnab) { FactoryBot.create(:cnab) }

  it 'all params is valid' do
    expect(cnab).to be_valid
  end

  describe 'validate presence' do
    it 'validate_presence_of type_cnabs' do
      expect(cnab.type_cnabs.present?).to eq(true)
    end

    it 'validate_presence_of date_occurrence' do
      expect(cnab.date_occurrence.present?).to eq(true)
    end

    it 'validate_presence_of value' do
      expect(cnab.value.present?).to  eq(true)
    end

    it 'validate_presence_of card' do
      expect(cnab.card.present?).to eq(true)
    end

    it 'validate_presence_of hours' do
      expect(cnab.hours.present?).to eq(true)
    end
  end
end
