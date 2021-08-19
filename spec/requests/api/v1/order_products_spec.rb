require 'rails_helper'

RSpec.describe "Api::V1::OrderProducts", type: :request do
    describe "GET /api/v1/orders/:id/order_products" do
        let(:order){ create(:order) }
        
        before do
            @order_products = create_list(:order_product, 0, order: order)
            get "/api/v1/orders/#{order.id}/order_products"
        end
        it 'Return a Serialized records' do
            expect(json).to eql(each_serialized(Api::OrderProductSerializer, @order_products))
        end
        it "Returns Http Success" do
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(0)
        end
        
    end
    describe "POST /api/v1/orders/:id/order_products" do
        context "with valid params" do
            let(:order){ create(:order) }
            let(:product){ create(:product) }
            let(:order_product_params) { attributes_for(:order_product, product_id: product.id) }

            before do 
                post "/api/v1/orders/#{order.id}/order_products", params: { order_product: order_product_params }
            end

            it { expect(response).to have_http_status(:created) }

            it 'Creates the right record' do
                expect(OrderProduct.last.product_id).to eq(order_product_params[:product_id])
                expect(OrderProduct.last.quantity).to eq(order_product_params[:quantity])
            end
        end
    end
end