class Api::V1::OrderProductsController < Api::V1::ApiController
    before_action :set_order, only: %i[create index]
    before_action :set_order_product, except: %i[create index]

    def index
        @order_products = @order.order_products
        render json: @order_products
    end

    def show
        order_product = OrderProduct.find(params[:id])
        render json: order_product, status: :ok
    end

    def create
        @order_product = @order.order_products.build(order_product_params)
        
        if order_product.save
        render json: order_product, status: :created
        else
        render json: order_product.errors, status: :unprocessable_entity
        end
    end

    def update
        order_product = OrderProduct.find(params[:id])
        if order_product.update_attributes(product_params)
        render json: order_product, status: :ok
        else
        render json: order_product.errors, status: :unprocessable_entity
        end
    end

    def destroy
        order_product = OrderProduct.find(params[:id])
        if order_product.destroy
        head :ok
        else
        render json: order_product.errors, status: :unprocessable_entity
        end
    end

    private

    def set_order_product
        @order_product = OrderProduct.find_by!(id: params[:id])
    end
    
    def set_order
        @order = Order.find_by!(id: params[:order_id])
    end
    
    def order_product_params
        params.require(:order_product).permit(:product_id, :quantity)
    end
end