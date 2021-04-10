# frozen_string_literal: true

class Buyer < ApplicationRecord
  has_many :orders
end
