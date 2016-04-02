class WineService

  def delete_all_external_products
    Product.where(:wine_id.ne => nil).delete_all
  end

  def fetch # Just leaving api key here bad practice buy only sample app
    #TODO_bg_job wite up as background job if I have time

    #Catch exception if wine API server is not online
    make_request

    case @response.code
      when 200
        save_new_products
      when 400...600
        puts "Remote Server Error #{response.code}"
        false
    end
  end

  protected

  def make_request
    begin
      @response = HTTParty.get('http://services.wine.com/api/beta2/service.svc/JSON/catalog?size=5&apikey=4e8e30a1ae80884240dd55730ea3723c', format: :json)
    rescue Timeout::Error
      puts 'Request Timed out, please try again later'
    end
  end

  def save_new_products
    return false if @response['Status']['ReturnCode'] != 0 # TODO implement other statuses
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
end



# http://services.wine.com/api/beta2/service.svc/format/catalog