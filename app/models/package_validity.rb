class PackageValidity < ApplicationRecord
  belongs_to :product_package
  belongs_to :validity_period
end
