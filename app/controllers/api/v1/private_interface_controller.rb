class Api::V1::PrivateInterfaceController < Api::V1::BaseController

	before_action :authenticate_api

	include FeedModelPrice
	
end
