require 'csv'
class Api::V1::ImportsController < Api::V1::ApiController
  
  skip_before_action :verify_authenticity_token
  
  def csv
    table = CSV.parse(File.read(import_params), headers: true) 
    result = ::Api::V1::Services::Imports::CsvService.new(table).perform

    Product.insert_all(result[:products])
    Load.insert_all(result[:loads])
    Order.insert_all(result[:orders])
    OrderProduct.insert_all(result[:order_products])
    
    head :created

  end

  private

  def import_params
    params.require(:file)
  end


  
end