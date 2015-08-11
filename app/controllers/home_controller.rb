class HomeController < ApplicationController

	before_filter :authenticate_admin!

	#Function to show home page
	def index
		redirect_to oauth_applications_path
	end
end
