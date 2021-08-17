class Api::V1::OrdersController < Api::V1::ApiController
    before_action :set_load, only: %i[index create]
    before_action :set_order, except: %i[index create]
    
    def index
        @orders = Order.all
        render json: @orders
    end

    def show_sorted
        render json: @order.sorted_order_products
    end

    def show
        render json: order, status: :ok
    end

    def create
        @order = @load.orders.build(order_params)

        if order.save
            render json: order, status: :created
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    def update
        order = Order.find(params[:id])
        if order.update_attributes(order_params)
            render json: order, status: :ok
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    def destroy
        unless @order.order_products.present? || @order.sorted_order_products.present?
            @order.destroy
            render status: :ok
        else
        render json: "Não é possivel excluir uma gravata com items associados.", status: :unprocessable_entity
        end  
    end

    private

    def order_params
        params.require(:order).permit(:code, :bay)
    end

    def set_order
        @order = Order.find(params[:id])
    end

    def set_load
        @load = Load.find_by(id: params[:load_id])
    end

end