# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    item do
      {
        id: Faker::Number.number(digits: 7),
        title: Faker::Number.number(digits: 7)
      }
    end
    quantity { Faker::Number.number(digits: 1) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    full_unit_price { unit_price }

    order
  end
end
