# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false
      t.bigint :external_id
      t.string :title
      t.integer :quantity
      t.float :unit_price
      t.float :full_unit_price

      t.timestamps
    end
  end
end
