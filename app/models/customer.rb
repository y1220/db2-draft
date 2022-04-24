class Customer < ApplicationRecord
    has_many :service_activation_schedule
    has_many :orders, through: :service_activation_schedule
end
