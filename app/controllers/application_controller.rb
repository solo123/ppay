class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protected

    def layout_by_resource
      if devise_controller?
        "admin_login"
      else
        "application"
      end
    end

  before_action :authenticate_user!

  # Overwriting the sign_out redirect path method
  # def after_sign_out_path_for(resource_or_scope)
  #   'http://www.baidu.com'
  # end

  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:mobile, :password, :password_confirmation, :remember_me) }
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:mobile, :email, :password, :remember_me) }
  #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  # end

end
