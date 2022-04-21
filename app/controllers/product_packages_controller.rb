class ProductPackagesController < ApplicationController
  def index

    @packages = ProductPackage.all
  end
end
