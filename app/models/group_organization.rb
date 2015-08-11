class GroupOrganization < ActiveRecord::Base

	has_many :organizations , dependent: :destroy
	belongs_to :country

	#Function to calculate model price
	def calculate_model_price(type, base_price)
		@organizations = organizations.where(org_type: type)

		@organizations.inject([]) do|result, organization|
			result << build_price_data(organization, base_price)
			result
		end
	end

	#Function to build price data
	def build_price_data(organization, base_price)
		{calculated_price: calculated_price(organization, base_price),
		 organization: organization.selected_fields}
	end

	#Function to find calculated price
	def calculated_price(organization, base_price)
		organization.calculate_pricing(base_price)
	end
end
