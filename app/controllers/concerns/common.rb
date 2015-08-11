module Common
  extend ActiveSupport::Concern

  UNAUTHORIZED_ACCESS = "Wrong app_id or app_secret. This application is not authorized to access the API."

  included do
    rescue_from ::Exception, with: :api_error
  end

  #Function to create access token
  def authenticate_api
  	@application = find_application
  	raise UNAUTHORIZED_ACCESS if @application.blank?
  end

  #Function to find application
  def find_application
  	Doorkeeper::Application.where(uid: auth_params[:app_id], secret: auth_params[:app_secret]).first
  end

  #function to show login params
  def auth_params
  	params.require(:app_id)
  	params.require(:app_secret)
  	params.permit(:app_id, :app_secret)
  end

  #Function to render API error JSON
  def api_error error
    @message = error.message
    render 'api/v1/base/fail'
  end

end