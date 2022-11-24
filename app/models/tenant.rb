class Tenant < ApplicationRecord
    validates :name, presence: true
    validates :age, presence: true
    validate :age_range
    has_many :leases, dependent: :destroy
    has_many :apartments, through: :leases

    def age_range
        if !age.nil?
            if( age <  18 )
                errors.add(:age, "must be 18 and above")    
            end
        end
    end
end
