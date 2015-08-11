require 'rails_helper'

RSpec.describe Organization, type: :model do

	before do
		`RAILS_ENV=test rake db:seed`
		@groups = GroupOrganization.first(3)
		@group_ids = @groups.collect(&:id).join(",")
		@organization = Organization.first
	end

	describe "fetch_by_organization_id method" do
		it "should fetch organizations for group ids" do
			@result = Organization.fetch_by_organization_id({group_organization_ids: "[#{@group_ids}]"})
			expect(@result.size).to eq 15
		end
	end

	describe "flexible_pricing method" do
		it "should calculate the flexible price" do
			@result = @organization.flexible_pricing(2.0)
			expect(@result).to eq 6.0
		end
	end

	describe "fixed_pricing method" do
		it "should calculate the fixed price" do
			@result = @organization.fixed_pricing(2.0)
			expect(@result).to eq 7.0
		end
	end

	describe "prestige_pricing method" do
		it "should calculate the prestige price" do
			@result = @organization.prestige_pricing(2.0)
			expect(@result).to eq 53.0
		end
	end

end
