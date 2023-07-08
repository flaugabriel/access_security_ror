# frozen_string_literal: true

class StoreCreator
  def self.create_store(cpf, store_owner, store_name, new_total)
    Store.create!(
      cpf:,
      store_owner: store_owner.strip,
      store_name: store_name.strip,
      balance_total: new_total
    )
  end
end
