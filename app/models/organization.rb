class Organization < ActiveRecord::Base

	require 'open-uri'

	has_many :locations, dependent: :destroy
	belongs_to :group_organization
	
	include PricingCalculator

	#Function to find all organization
	def self.fetch_by_organization_id(param)
		group_ids = JSON.parse(param[:group_organization_ids])
		where(group_organization_id: group_ids).
		select(:name, :public_name, :org_type, :pricing_policy, :id).to_a
	end

	#Function to strip selected field
	def selected_fields
		{
		 id: id, 
		 name: name, 
		 public_name: public_name, 
		 org_type: org_type, 
		 pricing_policy: pricing_policy
		}
	end

end
