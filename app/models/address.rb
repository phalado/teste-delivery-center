# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :buyer
  belongs_to :shipping, optional: true
end
