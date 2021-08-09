module Api
    module V1
        class LoadsController < ApplicationController
        before_action :set_load, only: [:create, :index]
        before_action :set_order, except: [:create, :index]
    
        def index
            @orders = @load.orders
            render json: { data: loads }, status: :ok
        end
    
        def show
            render json: @order
        end
    
        def show_ordenated
            render json: @order.sorted_order_products
        end
    
        def create
            @order = @load.orders.build(order_params)
    
            if @order.save
                render json: @order, status: :created
            else
                render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
            end
        end
    
        def update
            if @order.update(order_params)
                render json: @order, status: :ok
            else
                render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
            end
        end
    
        def destroy
            unless @order.order_products.present? || @order.sorted_order_products.present?
                @order.destroy
                render status: :ok
            else
                render json: "Não é possível excluir com Items associados", status: :unprocessable_entity
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
    end
end