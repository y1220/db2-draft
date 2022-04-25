class OrdersController < ApplicationController
  def index
  end

  def confirm_form
    @order = Order.find_by(id: params[:id], customer_id: session[:customer_id])
    if @order
      @package= ProductPackage.find(@order.product_package_id)
      @prices= @order.product_package.products.map {|product|
        Price.where(validity_period_id: @order.validity_period_id, product_id: product.id)[0].amount
      }
      @optional_prices= @order.optional_products.map(&:monthly_fee)
      @total1= @prices.inject(:+)
      @total2= @optional_prices.inject(:+)
      @order.amount= @total2? @total1 + @total2 : @total1
      @order.save
      flash[:notice]= "Please check the deatils of order"
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
      # flash[:notice]= "Please test payment"
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
        @customer= Customer.find(session[:customer_id])
        if @customer.is_insolvent
          if Order.where(status: false, customer_id: @customer.id).count ==0
            @alert= Alert.find_by(customer_id: @customer.id)
            if @alert
              @alert.destroy
              @customer.is_insolvent= false
              @customer.num_fails= 0
              @customer.save
            end
          end
        end
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
      #@customer.num_fails= Order.where(status: false, customer_id: @customer.id).count
      @customer.num_fails= @customer.num_fails + 1
      @customer.save
      if @customer.num_fails > 2 &&  !Alert.find_by(customer_id: @customer.id)
       @alert= Alert.new(customer_id: @customer.id, username: @customer.username, email: @customer.email, numOfFailedPayments: @customer.num_fails, lastRejectionDate:  DateTime.now)
       @alert.numOfFailedPayments = @customer.num_fails
       @alert.lastRejectionDate = DateTime.now
       @alert.amount = @order.amount
       if @alert.save
        flash[:notice]= "You have added into alert table!"
       end
      elsif Alert.find_by(customer_id: @customer.id)
        @alert= Alert.find_by(customer_id: @customer.id)
        @alert.numOfFailedPayments = @customer.num_fails
        @alert.lastRejectionDate = DateTime.now
        @alert.amount = @order.amount
        if @alert.save
         flash[:notice]= "Alert table has been updated!"
        end
      end
      # flash[:notice]= "Payment failed..try again!"
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
