class PackageOptional < ApplicationRecord
  belongs_to :product_package
  belongs_to :optional_product
end
