class Location < ActiveRecord::Base

	belongs_to :organization

	#Function to find all organization
	def self.fetch_by_organization_id(param)
		p group_id = param[:group_organization_id]
		joins(organization: :group_organization)
		.where("group_organizations.id = ?", group_id)
		.select(:name, :id).to_a
	end
end
