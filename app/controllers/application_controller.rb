class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :phonenumber, :role, :image, :email, :password) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :phonenumber, :role, :image, :email, :password, :current_password) }
    end

    def require_admin
      if user_signed_in? && !current_user.admin?
        flash[:danger] = "Only admin user can perform this action."
        redirect_to root_path
      end
    end

    def hours_in_a_day(att)
      if (att.check_in != nil && att.check_out != nil)
        hour = (att.check_out.hour - att.check_in.hour).to_f
        min = (att.check_out.min - att.check_in.min).to_f
        hour + (min/100)
      else
        0
      end
    end


end
