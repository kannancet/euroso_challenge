class SeedData

	class << self

		#seed all countries
		def seed_countries
			3.times do
				p "Creating country #{country_id}"
			  Country.create(name: "Country#{country_id}", 
			  							 country_code: "Cnt Code#{country_id}")
			end
		end

		#Seed locations
		def seed_group_organizations
			Country.find_each do |country|
				add_two_group_orgs(country)
			end
		end

		#Function to add two group orgs for country
		def add_two_group_orgs(country)
			2.times do 
				p "Adding group organization #{group_org_id} for country #{country.id}"
			  country.group_organizations.create(name: "Group Org #{group_org_id}", 
			  																	 organization_code: "Grp Code#{group_org_id}")
			end
		end

		#Seed Organizations
		def seed_organizations
			GroupOrganization.find_each do |group_organization|
				add_a_showroom_and_service(group_organization)
			  add_three_deep_levels(group_organization)
			end
		end

		#Function to add a showroom and service 
		def add_a_showroom_and_service(group_organization)
			["Show room", "Service"].each do |type|
				p "Adding organization #{org_id} with type #{type}"
		  	group_organization.organizations.create(name: "Org #{org_id}", 
		  																			  	public_name: "Code#{org_id}",
		  																			  	org_type: type,
		  																			  	pricing_policy: PRICING_SLAB.sample)
		  end		
		end

		#Function to add deep level relations
		def add_three_deep_levels(group_organization)
		  service = group_organization.organizations.where(org_type: "Service").first
		  first_dealer = create_child_dealer(group_organization, service)
		  p "Adding 1 child dealer #{first_dealer.id} for Group org : #{group_organization.id}"
		  create_two_subchild_dealers(group_organization, first_dealer)
		end

		#Function to add subshild dealers
		def create_two_subchild_dealers(group_organization, first_dealer)
			2.times do 
				p "Adding 1 sub child dealers for first dealer #{first_dealer.id} and Group org : #{group_organization.id}"
			  create_child_dealer(group_organization, first_dealer)
			end
		end

		#Function to create child for organization
		def create_child_dealer(group_organization, parent)
			group_organization.organizations.create(name: "Org #{org_id}", 
																				  	  public_name: "Code#{org_id}",
																				  	  org_type: "Dealer",
																				  	  parent_organization_id: parent.id,
																				  	  pricing_policy: PRICING_SLAB.sample)

			group_organization.organizations.where(org_type: "Dealer").first
		end

		#Function to add locations
		def seed_locations
			Organization.find_each do |organization|
				add_two_locations(organization)
			end
		end

		#Function to add two locations
		def add_two_locations(organization)
			2.times do 
				p "Adding 1 location for organization #{organization.id}"
				organization.locations.create(name: "Location #{location_id}",
																			address: "Location Addr #{location_id}")
			end
		end

		#Function to show organization count
		def org_id
			Organization.count + 1
		end

		#Function to show organization count
		def group_org_id
			GroupOrganization.count + 1
		end

		#Function to show organization count
		def location_id
			Location.count + 1
		end

		#Function to show country id
		def country_id
			Country.count + 1
		end

		#Function to flush database
		def flush_database
			p "Flushing Database"
			Admin.destroy_all
			Country.destroy_all
			Doorkeeper::Application.destroy_all
		end

		#Function to seed admin
		def seed_admin
			Admin.create(email: 'admin@euroso.com', password: "123qweAadmin")
			p "Pease login to admin using email - admin@euroso.com and password - 123qweAadmin "
		end

		#Function to seed API key
		def seed_api_key
			Doorkeeper::Application.create(name: "sample app", 
																		 uid: "836ec399a145ffafbd7774c57e06960397b77a53bb1ccc03d4e45d95d0c31a3d",
																		 secret: "cf8dc84d17c69e17a8b9d74ec971bdb636f231d3ba7d2ad2ebfca45bdc8ae3c9",
																		 redirect_uri: "urn:ietf:wg:oauth:2.0:oob")
		end

		#Function to start process
		def run
			flush_database
			seed_countries
			seed_group_organizations
			seed_organizations
			seed_locations
			seed_admin
			seed_api_key
		end
	end
end