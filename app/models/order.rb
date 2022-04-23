class Order < ApplicationRecord
  belongs_to :product_package
  belongs_to :optional_product
  belongs_to :customer
  belongs_to :validity_period
end
