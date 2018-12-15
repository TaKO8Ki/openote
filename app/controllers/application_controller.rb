class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?


    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:picture])
        devise_parameter_sanitizer.permit(:account_update, keys: [:picture])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:description])
        devise_parameter_sanitizer.permit(:account_update, keys: [:description])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_id])
        devise_parameter_sanitizer.permit(:account_update, keys: [:profile_id])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:link])
        devise_parameter_sanitizer.permit(:account_update, keys: [:link])
    end
end
