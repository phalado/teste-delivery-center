class CreateBuyers < ActiveRecord::Migration[6.1]
  def change
    create_table :buyers do |t|
      t.bigint :external_id
      t.string :nickname
      t.string :email
      t.jsonb :phone, default: { area_code: '', number: '' }
      t.string :first_name
      t.string :last_name
      t.jsonb :billing_info, default: { doc_type: '', doc_number: '' }

      t.timestamps
    end
  end
end  
