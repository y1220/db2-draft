class AddColumnStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :boolean
  end
end
