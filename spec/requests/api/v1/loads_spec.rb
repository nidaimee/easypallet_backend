require 'rails_helper'

RSpec.describe "Api::V1::Loads", type: :request do
    describe "GET /api/v1/loads" do
        before do
            @loads = create_list(:load, 1)
            get '/api/v1/loads'
        end
        it "Returns http success" do
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)
        end
        
        it 'Return a Serialized Records' do
            expect(json).to eql(each_serialized(Api::LoadSerializer, @loads))
        end
    end

    describe "POST /api/v1/loads" do
        it 'Create New' do
            expect {
                post '/api/v1/loads', params: { load: {code: 'Teste1', delivery_date:'2021-08-18'} }
            }.to change { Load.count }.from(0).to(1)
            expect(response).to have_http_status(:created)
        end
        context "Invalid params" do
            let(:load_params) { {foo: :bar} }
        
            before do 
                post '/api/v1/loads', params: { load: load_params }
            end
                
            it "Returns a json with error messages" do
                expect(response).to have_http_status(201)
            end
        end
    end

    describe "DELETE /api/v1/loads/:id" do
        let!(:load) { FactoryBot.create(:load, code: 'Teste1', delivery_date:'2021-08-18') }
        it 'Delete a Load' do
            expect {
            delete "/api/v1/loads/#{load.id}"
            }.to change { Load.count }.from(1).to(0)
            
            expect(response).to have_http_status(:ok)
        end 
    end

    describe "PUT /api/v1/loads/:id" do
        let(:load) { create(:load) }
        let(:load_params) { attributes_for(:load) }
    
        before do
            create_list(:load, 1)
            put "/api/v1/loads/#{load.id}", params: { load: load_params }
        end
    
        it "Updates the right record" do
            expect(Load.find(load.id).code).to eq(load_params[:code])
        end
    end
    
end
