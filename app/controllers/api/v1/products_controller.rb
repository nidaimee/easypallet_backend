class Api::V1::ProductsController < Api::V1::ApiController
    before_action :set_product, except: %i[index create]

    def index
        @products = Product.all
        render json: @products
    end

    def show
        product = Product.find(params[:id])
        render json: product, status: :ok
    end

    def create
        product = Product.new(product_params)
        if product.save
            render json: product, status: :created
        else
            render json: product.errors, status: :unprocessable_entity
        end
    end

    def update
        product = Product.find(params[:id])
        if product.update_attributes(product_params)
            render json: product, status: :ok
        else
            render json: product.errors, status: :unprocessable_entity
        end
    end

    def destroy
        unless @product.order_products.present? || @product.sorted_order_products.present?
        if product.destroy
            head :ok
        else
            render json: "Não é possivel excluir com items associados.", status: :unprocessable_entity
        end
    end

    private

    def set_post
        product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:label, :ballast)
    end
end