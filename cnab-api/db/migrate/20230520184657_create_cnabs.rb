# frozen_string_literal: true

class CreateCnabs < ActiveRecord::Migration[7.0]
  def change
    create_table :cnabs do |t|
      t.integer :type_cnabs
      t.date :date_occurrence
      t.decimal :value
      t.integer :card
      t.string :hours
      t.references :deal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
