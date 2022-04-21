class ProductComposition < ApplicationRecord
  belongs_to :product_package
  belongs_to :product
end
