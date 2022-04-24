class Order < ApplicationRecord
  belongs_to :product_package
  belongs_to :customer
  belongs_to :validity_period
  has_many :optional_product_orders
  has_many :optional_products, through: :optional_product_orders
end
