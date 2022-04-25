class EmployeesController < ApplicationController

  before_action :set_current_user

  def index
  end

  def create_package_form
  end

  def create_package
    if params[:package_name]
      @package= ProductPackage.new
      @package.assign_attributes(name: params[:package_name])
      @package.save
      (1..Product.all.count).to_a.each do |i|
        if params["products#{i.to_s}"]
          @product_composition= ProductComposition.new
          @product_composition.assign_attributes(product_package_id: @package.id, product_id: i)
          @product_composition.save
        end
      end
      (1..ValidityPeriod.all.count).to_a.each do |i|
        if params["periods#{i.to_s}"]
          @validity= PackageValidity.new
          @validity.assign_attributes(product_package_id: @package.id, validity_period_id: i)
          @validity.save
        end
      end
      (1..OptionalProduct.all.count).to_a.each do |i|
        if params["optionals#{i.to_s}"]
          @optional= PackageOptional.new
          @optional.assign_attributes(product_package_id: @package.id, optional_product_id: i)
          @optional.save
        end
      end
      flash[:notice]= "creation has been done successfully!"
      redirect_to("/product_packages/index")
    else
      flash[:notice]= "Something went wrong..try again!"
      render("/employees/create_package_form")
    end
  end

  def create_optional_form
  end

  def create_optional
    if params[:product_name] && params[:monthly_fee]
      @package= OptionalProduct.new
      @package.assign_attributes(name: params[:product_name], monthly_fee: params[:monthly_fee])
      @package.save
      flash[:notice]= "creation has been done successfully!"
      redirect_to("/product_packages/index")
    else
      flash[:notice]= "Something went wrong..try again!"
      render("/employees/create_package_form")
    end
  end

  def statistics
    @question1= "1. Number of total purchases per package."
    @question2= "2. Number of total purchases per package and validity period."
    @question3= "3. Total value of sales per package with and without the optional products."
    @question4= "4. Average number of optional products sold together with each service package."
    @question5= "5. List of insolvent users, suspended orders and alerts."
    @question6= "6. Best seller optional product, i.e. the optional product with the greatest value of sales across all the sold service packages."
    @packages= ProductPackage.all
    @insolvents= Customer.where(is_insolvent: true)
    @optionals= OptionalProduct.all
  end
end
