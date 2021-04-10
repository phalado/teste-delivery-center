class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :buyer
      t.bigint :external_id
      t.string :street_name
      t.string :street_number
      t.string :comment
      t.string :zip_code
      t.jsonb :city, default: { name: '' }
      t.jsonb :state, default: { name: '' }
      t.jsonb :country, default: { id: '', name: '' }
      t.jsonb :neighborhood, default: { id: '', name: '' }
      t.float :latitude
      t.float :longitude
      t.string :receiver_phone

      t.timestamps
    end
  end
end
