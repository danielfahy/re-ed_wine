class WineService

  def delete_all_external_products
    Product.where(:wine_id.ne => nil).delete_all
  end

  def fetch_new_products #If fetching thousands would use background jobs
    delete_all_external_products
    make_request(500)
    save_new_products if @response.code == 200
  end

  protected

  def make_request(number)
    begin     #Catch exception if wine API server is not online could add others
      @response = HTTParty.get("http://services.wine.com/api/beta2/service.svc/JSON/catalog?size=#{number}&apikey=#{api_key}", format: :json)
    rescue Timeout::Error
      puts 'Request Timed out, please try again later'
    end
  end

  def save_new_products
    return false if bad_return_code?
      products = @response.fetch('Products'){:products_not_found}.fetch('List'){:list_not_found}
      products.each do |p|
        Product.create(
          wine_id: p['Id'],
          name: p['Name'],
          description: p['Description'],
          )
      end
    true
  end

  def bad_return_code? #implement other statuses
    @response['Status']['ReturnCode'] != 0
  end

  def api_key #shouldn't be in version control in real app
    '4e8e30a1ae80884240dd55730ea3723c'
  end
end



# http://services.wine.com/api/beta2/service.svc/format/catalog