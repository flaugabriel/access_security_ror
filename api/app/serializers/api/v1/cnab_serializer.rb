# frozen_string_literal: true

module Api
  module V1
    class CnabSerializer < ActiveModel::Serializer
      attributes :id, :type_cnabs, :date_occurrence, :value, :card, :hours

      has_one :deal
      has_one :user
      has_one :store

      def date_occurrence
        object.date_occurrence.strftime('%d/%m/%Y') || ''
      end

      def type_cnabs
        object.deal.description || ''
      end
    end
  end
end
