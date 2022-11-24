class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :rent, :apartment_id, :tenant_id
  belongs_to :tenant
  belongs_to :apartment
end
