# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order

  validates_presence_of :item, :quantity, :unit_price
end
