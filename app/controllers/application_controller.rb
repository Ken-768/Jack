class ApplicationController < ActionController::Base
    def after_sign_out_path_for(resource)
        root_path
    end

    def after_sign_in_path_for(resource)
      user_path(id: current_user.id)
    end

    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :imagename]) 
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :imagename, :profile]) 
      
    end
end
