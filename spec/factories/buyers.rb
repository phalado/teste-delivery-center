FactoryBot.define do
  factory :buyer do
    external_id { Faker::Number.number(digits: 7) }
    email { Faker::Internet.email }
    phone do
      {
        area_code: Faker::Number.number(digits: 2),
        number: Faker::Number.number(digits: 9)
      }
    end
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { first_name + ' ' + last_name }
    billing_info do
      {
        doc_type: %i[CPF CNH RG].sample,
        doc_number: Faker::Number.number(digits: 11)
      }
    end
  end
end
