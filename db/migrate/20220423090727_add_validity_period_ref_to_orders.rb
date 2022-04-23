class AddValidityPeriodRefToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :validity_period, foreign_key: true
  end
end
