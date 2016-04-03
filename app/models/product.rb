class Product
  include Mongoid::Document

  field :name, type: String
  field :description, type: String, default: ''
  field :search_slug, type: String
  field :wine_id, type: Integer
  index( searchable_slug: 1)
  validates_presence_of :name

  def self.search(text)
    if text
      where(name: /#{text}/i)
    else
      scoped
    end
  end

  def short_description
    if description.length < 30
      clean_description
    else
      clean_description.slice(0..27) << '...'
    end
  end

  def clean_description # removes any html tags in the description
    description.gsub( %r{</?[^>]+?>}, '' )
  end

  def page # Should be in presenter
    i = Product.where(:name.lt => name).order_by(:name => 'asc').count
    page = i /  WillPaginate.per_page
    page += 1
    "?page=#{page}"
  end

  def image_url
    if wine_id.present?
      "http://cache.wine.com/labels/#{wine_id}l.jpg"
    else
      '/assets/own_wine.jpg'
    end
  end
end