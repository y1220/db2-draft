class ProductPackage < ApplicationRecord
    has_many :product_composition
    has_many :products, through: :product_composition
end
