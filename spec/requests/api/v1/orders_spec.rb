require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
    describe "GET /api/v1/orders/:id" do

        let(:order) { create(:order) }
        before do
            get "/api/v1/orders/#{order.id}"
        end

        it "Returns http success" do
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(6)
        end

        it 'Returns the correct order' do
            expect(json["id"]).to eql(order.id)
        end

        it 'Return a Serialized records' do
            expect(json).to eql(serialized(Api::OrderSerializer, order))
        end

    end

    describe "POST /api/v1/loads/:load_id/orders" do
        context "Valid params" do
            let(:order_params) { attributes_for(:order) }
            let(:load) { create(:load) }

            before do 
                post "/api/v1/loads/#{load.id}/orders", params: { order: order_params }
            end

            it { expect(response).to have_http_status(:created) }

            it 'Association with the load' do
                expect(Load.find(load.id).orders.count).to eq(1)
            end

            it 'Creating in the database' do
                expect(Order.count).to eq(1)
            end

            it 'Creating the record' do
                expect(Order.last.code).to eq(order_params[:code])
                expect(Order.last.bay).to eq(order_params[:bay])
            end
        end
    end

    describe "PUT /api/v1/loads/:load_id/orders/:id" do
        context "with valid params" do
            let(:order){ create(:order)}
            let(:order_params) { attributes_for(:order) }
        
            before do
                put "/api/v1/orders/#{order.id}", params: { order: order_params }
            end
        
            it "Updates the right record" do
                expect(Order.find(order.id).code).to eq(order_params[:code])
                expect(Order.find(order.id).bay).to eq(order_params[:bay])
            end
        end
    end

    describe "DELETE /api/v1/orders/:id" do
        let(:order) { create(:order) }
    
        context "When order has no record associated" do
            before do
                create_list(:order, 2)
                delete "/api/v1/orders/#{order.id}"
            end
        
            it { expect(response).to have_http_status(:ok) }
        
            it 'Remove correctly' do
                expect(Order.find_by(id: order.id)).to be(nil)
            end
        end 
    end

    describe 'GET /api/v1/orders/:id/sorted' do
        let(:order) { create(:order) }

        before do
            create_list(:order_product, 0, order: order)
            get "/api/v1/orders/#{order.id}/sorted"
        end

        it "Returns http success" do
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(0)
        end
    end

end
