class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_method
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end
    def destroy
        lease = find_lease
        lease.destroy
        render status: :no_content
    end

    private
    def find_lease
        Lease.find_by!(id: params[:id])
    end

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

    def record_not_found
        render json:{erorr: "Lease not found"}, status: :not_found
    end
    
    def unprocessable_entity_method e
        render json:{erorrs: e.record.errors}, status: :unprocessable_entity
    end
end
