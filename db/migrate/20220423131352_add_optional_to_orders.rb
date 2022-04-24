class AddOptionalToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :optional_product_order, null: false, foreign_key: true
    add_column :orders, :start_date, :datetime
  end
end
