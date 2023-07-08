# frozen_string_literal: true

class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.integer :type_transaction
      t.string :description
      t.string :nature
      t.string :signal

      t.timestamps
    end
  end
end
