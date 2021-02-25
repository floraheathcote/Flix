class ApplicationController < ActionController::Base

    add_flash_types(:danger)

private

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user

    def current_user?(user)
        user == current_user
    end

    helper_method :current_user?

    def current_user_admin?
        current_user && current_user.admin?
    end

    helper_method :current_user_admin?

    def require_signin
        unless current_user
            session[:intended_url] = request.url
            redirect_to signin_url, alert: "Please sign in first"
        end
    end

    # helper_method :require_signin

    def require_admin_user
        unless current_user_admin?
            session[:intended_url] = request.url
            redirect_to root_url, alert: "You are not authorised to view the requested page"
        end
    end

    # helper_method :require_admin_user
end
