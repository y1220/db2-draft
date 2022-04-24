class RemoveOptionalFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :optional_product_order, null: false, foreign_key: true
  end
end
