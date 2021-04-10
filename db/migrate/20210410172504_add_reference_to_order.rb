class AddReferenceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :buyer
  end
end
