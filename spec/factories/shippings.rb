FactoryBot.define do
  factory :shipping do
    external_id { Faker::Number.number(digits: 7) }
    shipment_type { 'shipping' }
    date_created { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }

    association :receiver_address, factory: :address
    order
  end
end
