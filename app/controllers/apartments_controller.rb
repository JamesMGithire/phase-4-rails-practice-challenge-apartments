class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_method
    
    def index 
        render json: Apartment.all
    end

    def show
        apartment = find_apartment
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created 
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        render status: :no_content
    end

    def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    end
    
    private
    def find_apartment
        Apartment.find_by!(id: params[:id])
    end

    def apartment_params
        params.permit(:number)
    end
    
    def record_not_found
        render json: {error: 'Apartment not found'}, status: :not_found
    end

    def unprocessable_entity_method e
        render json: {error: e.record.errors}, status: :unprocessable_entity
    end
end
