class ProductPackagesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    session[:ordertype]=nil
    @packages = ProductPackage.all
  end

  def order_type
    session[:ordertype]= params[:ordertype]
    flash[:notice]= "fill the details of order"
    redirect_to("/product_packages/order_detail_form")
  end

  def order_detail_form
    @order_type= session[:ordertype]
    @package= ProductPackage.find(@order_type)
    @products= @package.products
    @durations= @package.validity_periods.map(&:period)
    @optionals= @package.optional_products
  end

  def order_detail
    @order = Order.new
    @package= ProductPackage.find(session[:ordertype])
    @order.assign_attributes(product_package_id: session[:ordertype], customer_id: session[:customer_id],
      validity_period_id: params[:duration])
      d=DateTime.new(params[:event]["start_date(1i)"].to_i, params[:event]["start_date(2i)"].to_i, params[:event]["start_date(3i)"].to_i)
      @order.start_date = d
      if @order.save
          @package.optional_products.to_a.each do |optional|
            if params["optionals#{optional.id}"]
              @order_optional = OptionalProductOrder.new
              @order_optional.assign_attributes(optional_product_id: optional.id,
              order_id: @order.id)
              @order_optional.save
            end
          end
        session[:ordertype]=nil
        flash[:notice]= "Thank you for your order!"
        redirect_to("/orders/#{@order.id}/confirm_form")
      else
        @packages = ProductPackage.all
        show_error("Something went wrong..try again!","/product_packages/index")
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
