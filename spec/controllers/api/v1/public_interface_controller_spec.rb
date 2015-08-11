require 'rails_helper'

RSpec.describe Api::V1::PublicInterfaceController, type: :controller do
	render_views

	before do
		`RAILS_ENV=test rake db:seed`
		@groups = GroupOrganization.first(3)
		@group_ids = @groups.collect(&:id).flatten.join(",")
		@org_count = @groups.collect(&:organizations).flatten.size
		@loc_count_first_group = GroupOrganization.first.organizations.collect(&:locations).flatten.size
 		@request.env["HTTP_ACCEPT"] = "application/json"
 		@request.env["CONTENT_TYPE"] = "application/json"
	end

	describe 'GET Organizations API' do
	  it 'should return the list of organizations for group ids' do
	    get "feed_organization", {group_organization_ids: "[#{@group_ids}]"}, format: :json
      json = JSON.parse(response.body)
      
			expect(json["result"]).to eq "success"
			expect(json["message"]).to eq "Successfully fetched organization data."
			expect(json["data"]["organizations"].size).to eq @org_count
	  end
	end

	describe 'GET Locations API' do
	  it 'should return the list of locations for group ids' do
	    get "feed_location", {group_organization_id: GroupOrganization.first.id}, format: :json
      json = JSON.parse(response.body)

			expect(json["result"]).to eq "success"
			expect(json["message"]).to eq "Successfully fetched location data."
			expect(json["data"]["locations"].size).to eq @loc_count_first_group
	  end
	end
end
