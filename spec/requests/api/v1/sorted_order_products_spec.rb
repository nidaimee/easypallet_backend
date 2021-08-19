require 'rails_helper'

RSpec.describe "Api::V1::OrderProducts", type: :request do

    describe "GET /api/v1/orders/:id/sorted_order_products" do
        context "When Record Exist" do
            let(:order){ create(:order) }

            before do
                @sorted_order_products = create_list(:sorted_order_product, 10, order: order)
                get "/api/v1/orders/#{order.id}/sorted_order_products"
            end

            it { expect(response).to have_http_status(:success) }

            it 'Returns a list' do
                expect(json.count).to eql(10)
            end

            it 'Return a Serialized Records' do
                expect(json).to eql(each_serialized(Api::SortedOrderProductSerializer, @sorted_order_products))
            end
        end 
    end
end