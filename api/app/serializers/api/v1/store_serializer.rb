# frozen_string_literal: true

module Api
  module V1
    class StoreSerializer < ActiveModel::Serializer
      attributes :id, :store_owner, :cpf, :store_name, :balance_total
    end
  end
end
