# frozen_string_literal: true

class StoreUpdater
  def self.update_store(store, store_owner, store_name, signal, new_total)
    store.update(
      store_owner: store_owner.strip,
      store_name: store_name.strip,
      balance_total: store.balance_total.send(signal, new_total)
    )
  end
end
