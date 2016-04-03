require 'rails_helper'

RSpec.describe WineService do

  let(:service) { WineService.new }
  before do
    Fabricate.times(500, :product)
    Fabricate.times(15, :product, wine_id: nil)
  end

  describe 'delete_all_external_products' do
    subject { service.delete_all_external_products}
    it 'Deletes all products in the db that were obtained from the wine API' do
      expect{subject}.to change{Product.count}.by(-500)
    end
  end

  describe 'fetch_new_external_products' do
  # Should implement VCR to stop this actually making request to the wine API
    subject { service.fetch_new_products}
    it 'Adds 500 products to the database from the wine API -TODO stub request using VCR' do
      expect{subject}.to change{Product.count}.by(500)
    end
  end
end