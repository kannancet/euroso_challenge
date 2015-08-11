require 'rails_helper'

RSpec.describe Location, type: :model do

	before do
		`RAILS_ENV=test rake db:seed`
	end

	describe "Fetch organizations method" do
		it "should fetch all organizations for given group id" do
			@result = Location.fetch_by_organization_id({group_organization_id: GroupOrganization.first.id})
			expect(@result.size).to eq 10
		end
	end


end
