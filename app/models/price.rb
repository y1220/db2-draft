class Price < ApplicationRecord
  belongs_to :validityPeriod
  belongs_to :service
end
