# frozen_string_literal: true

class Shipping < ApplicationRecord
  belongs_to :order
  has_one :receiver_address, class_name: 'Address'
end
