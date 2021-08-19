require 'csv'
class Api::V1::ImportsController < Api::V1::ApiController
  
  skip_before_action :verify_authenticity_token
  
  def csv
    products = []
    loads = []
    orders = []
    order_products = []
    table = CSV.parse(File.read(import_params), headers: true) 
    table.each do |row|
      products.push(
        { id: row['product_id'], name: row['product_label'], ballast: row['ballast'], created_at: Time.now, updated_at: Time.now}
      )
      loads.push( 
        { id: row['load_id'], code: row['load_code'], delivery_date: row['delivery_date'], created_at: Time.now, updated_at: Time.now }
      )
      orders.push(
        { id: row['order_id'], code: row['order_code'], bay: row['bay'], load_id: row['load_id'], created_at: Time.now, updated_at: Time.now }
      )
      order_products.push(
        { id: row['order_product_id'], quantity: row['quantity'], order_id: row['order_id'], product_id: row['product_id'], created_at: Time.now, updated_at: Time.now }
      )
    end 
    Product.insert_all(products)
    Load.insert_all(loads)
    Order.insert_all(orders)
    OrderProduct.insert_all(order_products)
    head :created
  end

  private

  def import_params
    params.require(:file)
  end


  
end