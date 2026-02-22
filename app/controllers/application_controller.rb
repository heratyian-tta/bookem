class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    extra_keys = [:first_name, :last_name, :organization, :phone_number, :website]
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: extra_keys)
  end
end
