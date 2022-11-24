class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_method
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
    def index
        render json: Tenant.all
    end

    def show
        tenant = find_tenant
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        render status: :no_content
    end

    def update
        tenant =Tenant.find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end
    
    private
    def find_tenant
        Tenant.find_by!(id: params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def record_not_found
        render json: {error: 'Not Found'}, status: :not_found
    end

    def unprocessable_entity_method e
        render json: {error: e.record.errors}, status: :unprocessable_entity
    end
end
