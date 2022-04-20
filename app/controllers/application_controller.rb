class ApplicationController < ActionController::Base

    before_action :set_current_user

    def set_current_user
        @current_user= Customer.find_by(id: session[:customer_id])
        @name = @current_user ? @current_user.username : "Login"
    end

    def authenticate_user
        @current_user= Customer.find_by(id: session[:customer_id])
        if @current_user==nil
          redirect_to("/customers/login_form")
        end
    end
end
