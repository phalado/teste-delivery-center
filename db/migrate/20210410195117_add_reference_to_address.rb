class AddReferenceToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :shipping
  end
end
