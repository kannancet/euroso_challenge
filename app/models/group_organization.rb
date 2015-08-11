class GroupOrganization < ActiveRecord::Base

	has_many :organizations
	belongs_to :country
end
