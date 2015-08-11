require 'rails_helper'

RSpec.describe Api::V1::PrivateInterfaceController, type: :controller do
	
	render_views

	before do
		`RAILS_ENV=test rake db:seed`
		@group = GroupOrganization.first
		@pricing_params = {group_organization_id: @group.id, model_type_name: "Dealer", base_price: "2.0"}

 		@request.env["HTTP_ACCEPT"] = "application/json"
 		@request.env["CONTENT_TYPE"] = "application/json"
	end

	describe 'Calculate Pricing API' do
	  it 'should return the list of calculated prices' do
	  	params = TESTING_TOKENS.merge(@pricing_params)
	    post "feed_model_price", params, format: :json

      json = JSON.parse(response.body)
			expect(json["result"]).to eq "success"
			expect(json["message"]).to eq "Successfully fetched pricing data."
			expect(json["data"].size).to eq 3
			
	  end
	end
end
