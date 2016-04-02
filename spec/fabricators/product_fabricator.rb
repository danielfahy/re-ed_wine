Fabricator(:product) do
  name { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  search_slug { 'TODO' }
  wine_id { Faker::Number.number(10) }
end
