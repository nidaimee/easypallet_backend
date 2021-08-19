class Api::V1::SortedOrderProductsController < Api::V1::ApiController
    before_action :set_order

    def index
        @sorted_order_products = @order.sorted_order_products
        render json: @sorted_order_products
    end

    private

    def set_order
        @order = Order.find_by!(id: params[:order_id])
    end
end