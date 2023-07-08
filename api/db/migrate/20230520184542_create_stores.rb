# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :store_owner
      t.string :cpf
      t.string :store_name
      t.decimal :balance_total

      t.timestamps
    end
  end
end
