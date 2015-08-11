module FeedOrganization
  extend ActiveSupport::Concern

  SUCCESS_MESSAGE = "Successfully fetched organization data."
  NO_RESULT_MESSAGE = "No results to display. Please try using different group ids."

  #Function to feed organizations
  def feed_organization
  	@organizations = Organization.fetch_by_organization_id(organization_params)
  	set_message_org 
  	render_organization
  end

  #Organization params
  def organization_params
    params.require(:group_organization_ids)
  	params.permit(:group_organization_ids)
  end

  #Function to render organization
  def render_organization
  	render "api/v1/shared/feed_organization"
  end

  #Function to set message
  def set_message_org
  	@message = if @organizations.blank? 
						  		NO_RESULT_MESSAGE
						  	else
						  		SUCCESS_MESSAGE
						  	end
  end
end