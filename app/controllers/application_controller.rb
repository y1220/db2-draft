class ApplicationController < ActionController::Base

    before_action :set_current_user

    def set_current_user
        @emp= Employee.find_by(id: session[:employee_id])
        @current_user= Customer.find_by(id: session[:customer_id])
        if @emp
            @name= "Employee"
        elsif @current_user
            @name= @current_user.username
        else
            @name= "Login"
        end
    end

    def authenticate_user
        @current_user= Customer.find_by(id: session[:customer_id])
        if @current_user==nil
          redirect_to("/customers/login_form")
        end
    end
end
