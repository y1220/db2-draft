class AddNumberOfFailToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :num_fails, :integer
  end
end
