module FeedModelPrice
  extend ActiveSupport::Concern

  SUCCESS_MESSAGE = "Successfully fetched pricing data."
  NO_RESULT_MESSAGE = "No results to display. Please try using different group id."

  #Function to find model type price
  def feed_model_price
  	@group = GroupOrganization.find_by_id(model_params[:group_organization_id])
  	@price_data = calculate_model_price
  	set_message_price
  end

  #Fucntion to calculate model price
  def calculate_model_price
  	@group.calculate_model_price(model_params[:model_type_name], model_params[:base_price])
  end

  #Function to set message
  def set_message_price
  	@message = if @price_data.blank? 
						  		NO_RESULT_MESSAGE
						  	else
						  		SUCCESS_MESSAGE
						  	end
  end

  #Function to set model params
  def model_params
  	params.require(:group_organization_id)
  	params.require(:model_type_name)
  	params.require(:base_price)
  	params.permit(:group_organization_id, :model_type_name, :base_price)
  end
  
end