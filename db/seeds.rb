class SeedData

	class << self

		#seed all countries
		def seed_countries
			5.times do |country_id|
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
			  country.group_organizations.create(name: "Group Org #{group_org_id}", 
			  																	 organization_code: "Grp Code#{group_org_id}")
			end
		end

		#Seed Organizations
		def seed_organizations
			GroupOrganization.find_each do |group_organization|
				add_a_showroom_and_service(group_organization)
			  add_deep_level_relations(group_organization)
			end
		end

		#Function to add a showroom and service 
		def add_a_showroom_and_service(group_organization)
			["Show room", "Service"].each do |type|
		  	group_organization.organizations.create(name: "Org #{org_id}", 
		  																			  	public_name: "Code#{org_id}",
		  																			  	type: type,
		  																			  	pricing_policy: PRICING_SLAB[type])
		  end		
		end

		#Function to add deep level relations
		def add_deep_level_relations(group_organization)
		  service = group_organization.organizations.where(type: "Service").first
		  first_dealer = create_child_dealer(group_organization, service)
		  create_subchild_dealers(group_organization, first_dealer)
		end

		#Function to add subshild dealers
		def create_subchild_dealers(group_organization, first_dealer)
			2.times do 
			  create_child_dealer(group_organization, first_dealer)
			end
		end

		#Function to create child for organization
		def create_child_dealer(group_organization, parent)
			group_organization.organizations.create(name: "Org #{org_id}", 
																				  	  public_name: "Code#{org_id}",
																				  	  type: "Dealer",
																				  	  parent_organization_id: parent.id,
																				  	  pricing_policy: PRICING_SLAB["Dealer"])

			group_organization.organizations.where(type: "Dealer").first
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

		#Function to start process
		def run
			seed_countries
			seed_group_organizations
			seed_organizations
			seed_locations
		end
	end
end

#Running seed class
SeedData.run