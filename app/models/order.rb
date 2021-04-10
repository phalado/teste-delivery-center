# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :buyer

  has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy
end
