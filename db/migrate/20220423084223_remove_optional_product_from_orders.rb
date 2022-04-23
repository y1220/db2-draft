class RemoveOptionalProductFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :optional_product, null: false, foreign_key: true
  end
end
