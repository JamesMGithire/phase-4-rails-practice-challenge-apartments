class Lease < ApplicationRecord
    validates :apartment_id, presence: true
    validates :tenant_id, presence: true
    validates :rent, presence: true
    belongs_to :apartment
    belongs_to :tenant
end
