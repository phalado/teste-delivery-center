class OrderItem < ApplicationRecord
  belongs_to :order

  validates_presence_of :external_id, :title, :quantity, :unit_price
end
