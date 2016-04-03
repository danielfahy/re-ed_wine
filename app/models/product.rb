SLUGIFY_PROC = Proc.new {|s| s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}
class Product
  include ActionView::Helpers::SanitizeHelper
  include Mongoid::Document

  field :name, type: String
  field :description, type: String, default: ''
  field :alpha_slug, type: String
  field :wine_id, type: Integer
  index( alpha_slug: 1) # easily add description to search results later if required
  validates_presence_of :name
  before_save :clean_description
  before_save :generate_slug

  def self.search(text)
    if text
      where(name: /#{text}/i)
    else
      scoped
    end
  end

  def short_description
    if description.length < 30
      description
    else
      description.slice(0..27) << '...'
    end
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

  protected

  def clean_description
    self.description = description.gsub( %r{</?[^>]+?>}, '' )
  end

  def generate_slug
    self.alpha_slug = SLUGIFY_PROC.call(name) # also removes non ascii characters
  end
end