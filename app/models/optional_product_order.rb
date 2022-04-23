class OptionalProductOrder < ApplicationRecord
  belongs_to :optional_product
  belongs_to :order
end
