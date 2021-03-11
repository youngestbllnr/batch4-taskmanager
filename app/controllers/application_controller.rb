class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        dashboard_path
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :email, :password, :current_password])
    end

end
