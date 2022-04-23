class ProductPackagesController < ApplicationController

  def index
    @packages = ProductPackage.all
  end

  def order_type
    session[:ordertype]= params[:ordertype]
    flash[:notice]= "fill the details of order"
    redirect_to("/product_packages/order_detail_form")
  end

  def order_detail_form
    @order_type= session[:ordertype]
    @products= ProductPackage.find(@order_type).products
    @durations= ValidityPeriod.all.map(&:period)
    @optionals= OptionalProduct.all
  end

  def order_detail
    @order = Order.new
      @order.assign_attributes(username: params[:customer_name], email: params[:email], password: params[:customer_password])
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

  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end

  def allowed_params
    params.require(:request)
  end

end
