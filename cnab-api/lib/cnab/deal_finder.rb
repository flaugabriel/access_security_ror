# frozen_string_literal: true

class DealFinder
  def self.find_by_type_transaction(type_transaction)
    Deal.find_by(type_transaction:)
  end
end
