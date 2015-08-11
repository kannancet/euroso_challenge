require 'rails_helper'

RSpec.describe GroupOrganization, type: :model do

	before do
		`RAILS_ENV=test rake db:seed`
		@group = GroupOrganization.first
	end

	describe "calculate_model_price method" do
		it "should calculate the model price and return" do
			@result = @group.calculate_model_price("Dealer", 2.0)
			expect(@result.size).to eq 3
		end
	end

	describe "calculate_model_price method" do
		it "should calculate the model price and return" do
			@result = @group.calculate_model_price("Dealer", 2.0)
			expect(@result.size).to eq 3
		end
	end
	
end
