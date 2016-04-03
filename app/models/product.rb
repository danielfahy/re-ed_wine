class Product
  include Mongoid::Document

  field :name, type: String
  field :description, type: String, default: ''
  field :search_slug, type: String
  field :wine_id, type: Integer
  index( searchable_slug: 1)
  validates_presence_of :name

  def short_description
    if description.length < 30
      clean_description
    else
      clean_description.slice(0..27) << '...'
    end
  end

  def clean_description
    description.gsub( %r{</?[^>]+?>}, '' )
  end
end