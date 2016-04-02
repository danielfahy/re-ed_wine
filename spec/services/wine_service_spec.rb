require 'rails_helper'

RSpec.describe WineService do

  let(:service) { WineService }
  before do
    Fabricate.times(500, :product)
    Fabricate.times(15, :product, wine_id: nil)
  end

  describe '::delete_all_external_products' do
    subject { service.delete_all_external_products}
    it 'Deletes all products in the db that were obtained from the wine API' do
      expect{subject}.to change{Product.count}.by(-500)
    end
  end

  #TODO_bg_job wite up as background job if I have time
  # describe '::fetch_new_external_products' do
  #   subject { service.fetch_new_external_products}
  #   it 'Queues a job in Sidekiq to fetch a new product list from the wine API' do
  #     expect{subject}.to change{FetchProductWorker.jobs.size}.by(1)
  #   end
  # end
end