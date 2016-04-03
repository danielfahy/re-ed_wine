Fabricator(:product) do
  name { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  wine_id { Faker::Number.number(10) }
end
