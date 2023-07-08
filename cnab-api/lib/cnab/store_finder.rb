# frozen_string_literal: true

class StoreFinder
  def self.find_by_cpf(cpf)
    Store.find_by(cpf:)
  end
end
