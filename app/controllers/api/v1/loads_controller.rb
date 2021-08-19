class Api::V1::LoadsController < Api::V1::ApiController
    before_action :set_load, except: [:index, :create]
    skip_before_action :verify_authenticity_token
    def index
        @loads = Load.all
        render json: @loads
    end

    def show
        load = Load.find(params[:id])
        render json: load, status: :ok
    end

    def create
        @load = Load.new(load_params)

        if @load.save
            render json: @load, status: :created
        else
            render json: { errors: @load.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        load = Load.find(params[:id])
        if load.update!(load_params)
            render json: load, status: :ok
        else
            render json: load.errors, status: :unprocessable_entity
        end
    end

    def destroy
        load = Load.find(params[:id])
        if load.destroy
        head :ok
        else
        render json: load.errors, status: :unprocessable_entity
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