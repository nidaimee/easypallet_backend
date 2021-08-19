require 'rails_helper'

RSpec.describe 'Products request', type: :request do
  describe "GET /api/v1/products" do
    it "Returns Http Success" do
      get "/api/v1/products"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end

  describe "POST /api/v1/products" do
    it 'New Product' do
      expect {
        post '/api/v1/products', params: { product: {name: 'Teste1', ballast:'Teste1'} }
      }.to change { Product.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /products/:id' do
    let!(:product) { FactoryBot.create(:product, name: 'teste', ballast: 'teste2') }
    it 'Delete' do
      expect {
        delete "/api/v1/products/#{product.id}"
      }.to change { Product.count }.from(1).to(0)
      
      expect(response).to have_http_status(:ok)
    end 
  end

  describe "PUT /api/v1/products/:id" do
    let(:product) { create(:product) }
    let(:product_params) { attributes_for(:product) }

    before do
      create_list(:product, 1)
      put "/api/v1/products/#{product.id}", params: { product: product_params }
    end

    it "Updates the right record" do
      expect(Product.find(product.id).name).to eq(product_params[:name])
    end
  end
end 
