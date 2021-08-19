class Api::V1::Services::Imports::CsvService

  def initialize (table)
    @products = []
    @loads = []
    @orders = []
    @order_products = []
    @table = table
  end

  def perform
    @table.each do |row|
      @products.push(
        { id: row['product_id'], name: row['product_label'], ballast: row['ballast'], created_at: Time.now, updated_at: Time.now}
      )
      @loads.push( 
        { id: row['load_id'], code: row['load_code'], delivery_date: row['delivery_date'], created_at: Time.now, updated_at: Time.now }
      )
      @orders.push(
        { id: row['order_id'], code: row['order_code'], bay: row['bay'], load_id: row['load_id'], created_at: Time.now, updated_at: Time.now }
      )
      @order_products.push(
        { id: row['order_product_id'], quantity: row['quantity'], order_id: row['order_id'], product_id: row['product_id'], created_at: Time.now, updated_at: Time.now }
      )
    end

    { products: @products,loads: @loads, orders: @orders, order_products: @order_products }
  end 


end