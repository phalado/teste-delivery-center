FactoryBot.define do
  factory :order_item do
    external_id { Faker::Number.number(digits: 7) }
    title { Faker::Lorem.word }
    quantity { Faker::Number.number(digits: 1) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    full_unit_price { unit_price }

    order
  end
end
