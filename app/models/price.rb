class Price < ApplicationRecord
  belongs_to :validity_period
  belongs_to :product
end
