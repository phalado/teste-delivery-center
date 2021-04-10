# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    external_id { Faker::Number.number(digits: 7) }
    order_external_id { Faker::Number.number(digits: 7) }
    payer_external_id { Faker::Number.number(digits: 7) }
    installments { Faker::Number.number(digits: 2) }
    payment_type { 'credit_card' }
    status { %i[approved not_approved].sample }
    transaction_amount { Faker::Number.decimal(l_digits: 2) }
    taxes_amount { Faker::Number.decimal(l_digits: 2) }
    shipping_cost { Faker::Number.decimal(l_digits: 2) }
    total_paid_amount { transaction_amount + taxes_amount + shipping_cost }
    installment_amount { total_paid_amount }
    date_approved { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    date_created { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
