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

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "Only admin user can perform this action."
        redirect_to users_path
      end
    end

    def require_same_user_and_attendence
      if ((current_user != @user && !current_user.admin?) && (current_user.attendences.first.id != @attendence.id))
        flash[:danger] = "Only admin user can perform this action."
        redirect_to users_path
      end
    end


end
