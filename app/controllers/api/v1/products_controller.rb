module Api
    module V1
        class ProductsController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_product, except: [:index, :create]

    def index
        products = Product.all
        render json: { data: products }, status: :ok
    end

    def create
        @product = Product.new(product_params)

        if @product.save
        render json: @product, status: :created
        else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render json: @product
        render json: { data: product }, status: :ok
    end

    def destroy
        unless @product.order_products.present? || @product.sorted_order_products.present?
        @product.destroy
        render status: :ok
        else
        render json: "Não é possivel excluir um produto com items associados.", status: :unprocessable_entity
        end  
    end

    def update
        if @product.update(product_params)
        render json: @product, status: :ok
        else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:name, :ballast)
    end

        end
    end
end