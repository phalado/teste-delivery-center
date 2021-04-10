# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    external_id { Faker::Number.number(digits: 7) }
    store_id { Faker::Number.number(digits: 3) }
    date_created { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    date_cloased { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    last_updated { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    total_amount { Faker::Number.decimal(l_digits: 2) }
    total_shipping { Faker::Number.decimal(l_digits: 2) }
    total_amount_with_shipping { total_amount + total_shipping }
    paid_amount { Faker::Number.between(from: 0.0, to: total_amount_with_shipping) }
    expiration_date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    status { 'paid' }
  end
end
