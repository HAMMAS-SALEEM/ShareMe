class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:error] = 'Access Denied'
    redirect_to root_path
  end

  add_flash_types :danger, :info, :warning, :success, :messages, :notice, :alert

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:Name, :Bio, :Photo, :email, :password, :role) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:Name, :Bio, :Photo, :email, :password, :current_password, :role)
    end
  end
end
