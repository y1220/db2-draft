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
    @order.assign_attributes(product_package_id: session[:ordertype], customer_id: session[:customer_id],
      validity_period_id: params[:duration], start_date: params[:start_date])
      if @order.save
          [1,2,3].each do |i|
            if params["optionals#{i}"]
              @order_optional = OptionalProductOrder.new
              @order_optional.assign_attributes(optional_product_id: i,
              order_id: @order.id)
              @order_optional.save
            end
          end
        session[:ordertype]=nil
        flash[:notice]= "Thank you for your order!"
        redirect_to("/orders/#{@order.id}/confirm_form")
      else
        show_error("Something went wrong..try again!","/product_packages/order_type")
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
