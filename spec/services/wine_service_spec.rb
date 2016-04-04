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
    it 'deletes the previous 500 products and adds a new 500 products -TODO stub request using VCR' do
      old_wine_ids = Product.all.map(&:wine_id)
      subject
      new_wine_ids = Product.all.map(&:wine_id)
      expect(new_wine_ids).to_not eq old_wine_ids
    end
    it "doesn't effect the manually added wine" do
      own_wine = Product.where(wine_id: nil).to_a
      subject
      expect(own_wine).to eq Product.where(wine_id: nil).to_a
    end
  end
end