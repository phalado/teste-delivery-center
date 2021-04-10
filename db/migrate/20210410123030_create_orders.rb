class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.bigint :external_id
      t.bigint :store_id
      t.datetime :date_created
      t.datetime :date_cloased
      t.datetime :last_updated
      t.float :total_amount
      t.float :total_shipping
      t.float :total_amount_with_shipping
      t.float :paid_amount
      t.datetime :expiration_date
      t.string :status

      t.timestamps
    end
  end
end
