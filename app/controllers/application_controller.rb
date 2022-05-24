class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages, :notice, :alert

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :current_password)
    end
  end
end
