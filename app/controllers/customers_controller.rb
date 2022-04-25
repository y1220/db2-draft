class CustomersController < ApplicationController

  before_action :authenticate_user ,{only: [:show]}
  before_action :set_current_user

  def index
  end

  def new
    @customer = Customer.new
  end

  def create
      @customer = Customer.new # Needed for printing error messages
      @customer.assign_attributes(username: params[:customer_name], email: params[:email], password: params[:customer_password], is_insolvent: false, num_fails: 0)
       if /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/.match(params[:email])
         if /^[a-zA-Z0-9_.+-]{4,8}$/.match(params[:customer_password])
           if @customer.save
             session[:customer_id]=@customer.id
             flash[:notice]= "Thank you for the registration!"
             redirect_to("/customers/personal/#{@customer.id}")
           else
             show_error("Something went wrong..try again!","customers/new")
           end
         else
           show_error("Inserted password is not valid..try again!","customers/new")
         end
       else
         show_error("Inserted email is not valid..try again!","customers/new")
       end
  end

  def show
    @customer = Customer.find_by(id: params[:id])
  end

  def login_form

  end

  def login
    @emp= Employee.find_by(email: params[:email], password: params[:password])
    if @emp
      session[:employee_id] = @emp.id
        flash[:notice]= "Loggined successfully!"
        redirect_to("/employees/index")
    else
    @customer = Customer.find_by(email: params[:email], password: params[:password])
      if @customer
        session[:customer_id] = @customer.id
        flash[:notice]= "Loggined successfully!"
        redirect_to("/customers/personal/#{@customer.id}")
      else
        flash[:notice]= "Something went wrong..try again!"
        render("/customers/login_form")
      end
    end
  end

  def logout
    session[:customer_id] = nil
    session[:employee_id] = nil
    flash[:notice]= "Logouted successfully!"
    redirect_to("/customers/login_form")
  end

  def activated
    @customer = Customer.find(session[:customer_id])
    if @customer
      @orders= @customer.orders
    else
      flash[:notice]= "Something went wrong..try again!"
      render("/customers/login_form")
    end
  end


  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end

  def allowed_params
    params.require(:request)
  end

end
