class Api::V1::ProductsController < Api::V1::ApiController
    skip_before_action :verify_authenticity_token
    before_action :set_product, except: [:index, :create]
    
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
        if product.update!(product_params)
            render json: product, status: :ok
        else
            render json: product.errors, status: :unprocessable_entity
        end
    end

    def destroy
        product = Product.find(params[:id])
        if product.destroy
            head :ok
        else
            render json: product.errors, status: :unprocessable_entity
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