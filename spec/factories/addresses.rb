FactoryBot.define do
  factory :address do
    external_id { Faker::Number.number(digits: 7) }
    street_name { Faker::Address.street_name }
    street_number { Faker::Address.building_number }
    comment { Faker::Lorem.sentence(word_count: 3) }
    zip_code { Faker::Address.zip_code }
    city do
      { name: Faker::Address.city }
    end
    state do
      { name: Faker::Address.state }
    end
    country do
      {
        id: 'BR',
        name: 'Brazil'
      }
    end
    neighborhood do
      {
        id: nil,
        name: Faker::Address.community
      }
    end
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    receiver_phone { Faker::Number.number(digits: 9) }

    buyer
  end
end
