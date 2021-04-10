class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.references :order, null: false
      t.bigint :external_id
      t.string :shipment_type
      t.datetime :date_created
      t.bigint :receiver_address

      t.timestamps
    end
  end
end
