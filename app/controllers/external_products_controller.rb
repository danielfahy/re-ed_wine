class ExternalProductsController < ApplicationController

  def index
    #noop
  end

  def destroy_all # if this was millions of records would use batching & polling
    render json: {success: WineService.new.delete_all_external_products}
  end

  def fetch_more
    render json: {success: WineService.new.fetch_new_products }
  end
end
