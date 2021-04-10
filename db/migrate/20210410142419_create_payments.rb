# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false
      t.bigint :external_id
      t.bigint :order_external_id
      t.bigint :payer_external_id
      t.integer :installments
      t.string :payment_type
      t.string :status
      t.float :transaction_amount
      t.float :taxes_amount
      t.float :shipping_cost
      t.float :total_paid_amount
      t.float :installment_amount
      t.datetime :date_approved
      t.datetime :date_created

      t.timestamps
    end
  end
end
