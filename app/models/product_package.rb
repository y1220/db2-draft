class ProductPackage < ApplicationRecord
    has_many :product_composition
    has_many :products, through: :product_composition
    has_many :package_validity
    has_many :validity_periods, through: :package_validity
    has_many :package_optional
    has_many :optional_product, through: :package_optional
end
