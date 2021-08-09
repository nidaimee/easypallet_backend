module Api
    module V1
        class LoadsController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_load, except: [:index, :create]

    def index
    loads = Load.all
    render json: { data: loads }, status: :ok
    end

    def create
        @load = Load.new(load_params)

        if @load.save
        render json: @load, status: :created
        else
        render json: { errors: @load.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render json: @load, serializer: Api::V1::LoadDetailSerializer 
    end

    def destroy
        unless @load.orders.present?
        @load.destroy
        render status: :ok
        else
        render json: "Não é possivel excluir uma carga com items associados.", status: :unprocessable_entity
        end  
    end

    def update
        if @load.update(load_params)
            render json: @load, status: :ok
        else
            render json: { errors: @load.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def set_load
        @load = Load.find(params[:id])
    end

    def load_params
        params.require(:load).permit(:code, :delivery_date)
    end

        end
    end
end