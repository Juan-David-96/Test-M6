class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, images_attributes: [:url, :context, :id]]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, images_attributes: [:url, :context, :id]]) 
  end
 
end
