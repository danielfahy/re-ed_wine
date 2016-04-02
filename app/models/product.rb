class Product
  include Mongoid::Document

  field :name, type: Symbol
  field :description, type: String
  field :search_slug, type: String
  field :wine_id, type: Integer
  index( searchable_slug: 1)
end