# frozen_string_literal: true

module Api
  module V1
    class DealSerializer < ActiveModel::Serializer
      attributes :id, :type_transaction, :description, :nature, :signal
    end
  end
end
