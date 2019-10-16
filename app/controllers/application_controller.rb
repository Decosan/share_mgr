class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def return_personnel_new
    if user_signed_in?
      unless current_user.admin?
        if current_user.personnel.nil?
          redirect_to new_personnel_path
        end
      end
    end  
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
