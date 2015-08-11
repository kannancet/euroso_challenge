module FeedLocation
  extend ActiveSupport::Concern

  SUCCESS_MESSAGE = "Successfully fetched location data."
  NO_RESULT_MESSAGE = "No results to display. Please try using different group ids."

  #Function to feed organizations
  def feed_location
    @locations = Location.fetch_by_organization_id(location_params)
    set_message_location
    render_location
  end

  #Function to render location
  def render_location
    render "api/v1/shared/feed_location"
  end

  #Organization params
  def location_params
    params.require(:group_organization_id)
    params.permit(:group_organization_id)
  end

  #Function to set message
  def set_message_location
    @message = if @locations.blank? 
                  NO_RESULT_MESSAGE
                else
                  SUCCESS_MESSAGE
                end
  end
end