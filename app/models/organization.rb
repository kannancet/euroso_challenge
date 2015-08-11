class Organization < ActiveRecord::Base

	has_many :locations
	belongs_to :group_organization
end
