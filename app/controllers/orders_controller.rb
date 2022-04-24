class OrdersController < ApplicationController
  def index
  end

  def confirm_form
    @order = Order.find_by(id: params[:id], customer_id: session[:customer_id])
    if @order
      @package= ProductPackage.find(@order.product_package_id)
      flash[:notice]= "Please check the deatils of order"
      @prices= @order.product_package.products.map {|product|
        Price.where(validity_period_id: @order.validity_period_id, product_id: product.id)[0].amount
      }
      @optional_prices= @order.optional_products.map(&:monthly_fee)
      @total1= @prices.inject(:+)
      @total2= @optional_prices.inject(:+)
    else
      flash[:notice]= "Something went wrong..try again!"
    end
  end

  def confirm
    @order = Order.find_by(id: params[:id], customer_id: session[:customer_id])
    if @order
      flash[:notice]= "Please check the deatils of order"
      redirect_to("/orders/#{@order.id}/payment")
    else
      flash[:notice]= "Something went wrong..try again!"
    end
  end

  def payment
    @order = Order.find_by(id: params[:id], customer_id: session[:customer_id])
    if @order
      flash[:notice]= "Please test payment"
    else
      flash[:notice]= "Something went wrong..try again!"
    end
  end

  def payment_success
    @order = Order.find_by(id: params[:id], customer_id: session[:customer_id])
    if @order
      @order.status= true
      @order.save
      @products= ProductPackage.find(@order.product_package_id).products
      @optional_products= @order.optional_products
      @activation= ServiceActivationSchedule.new(order_id: @order.id, customer_id: session[:customer_id],
      activation_date: @order.start_date, deactivation_date: @order.start_date + @order.validity_period.period.month)
      if @activation.save
        flash[:notice]= "Payment result SUCCESS!"
      else
        flash[:notice]= "Something went wrong..try again!"
      end
    else
      flash[:notice]= "Something went wrong..try again!"
    end
  end

  def payment_fail
    @order = Order.find_by(id: params[:id], customer_id: session[:customer_id])
    if @order
      @order.status= false
      @order.save
      @products= ProductPackage.find(@order.product_package_id).products
      @optional_products= @order.optional_products
      @customer= Customer.find_by(id: session[:customer_id])
      @customer.is_insolvent= true
      @customer.save
      flash[:notice]= "Payment result FAIL!"
    else
      flash[:notice]= "Something went wrong..try again!"
    end
  end

  def reset
    session[:ordertype] = nil
    flash[:notice]= "Session data has been removed"
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
