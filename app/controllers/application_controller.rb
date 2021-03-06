class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :after_sign_in_path_for
  before_filter :authenticate_gym!, :except => [:landing]

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:location, :email]
    devise_parameter_sanitizer.for(:sign_in) << :location
  end

  def after_sign_in_path_for(gym=nil)
    clients_url
  end
  def after_sign_out_path_for(gym=nil)
    root_url
  end
end
