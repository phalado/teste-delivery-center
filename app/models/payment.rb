# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :order

  validates_presence_of :external_id, :order_external_id, :payer_external_id
end
