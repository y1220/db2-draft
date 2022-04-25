class HomeController < ApplicationController

  before_action :set_current_user

  def index
    if session[:employee_id]
      @emp= Employee.find(session[:employee_id])
    end
    if @emp
    else
      @customer = Customer.find(session[:customer_id])
      if @customer
        if @customer.is_insolvent
          @is_insolvent = true
          @orders= Order.where(status: false, customer_id: @customer.id)
        end
      else
        @is_insolvent = false
      end
    end
  end
end
