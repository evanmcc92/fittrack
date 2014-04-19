class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper :all
  protected

  def configure_permitted_parameters
	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :name, :height, :measurement_system, :weight, :admin, :age, :gender, :bio, :password, :password_confirmation, :current_password, :email) }
  
	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :name, :measurement_system, :gender, :password, :password_confirmation, :email) }
  end
end
