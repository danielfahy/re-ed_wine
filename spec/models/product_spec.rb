require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) { Fabricate.build(:product)}
  describe 'methods' do
    describe 'save' do
      it 'removes html tags from the descrition when saving' do
        product.description = ' <p>' + product.description + ' </p>'
        product.save
        expect(product.description.include? '<p>').to eq false
      end
    end
  end
end
