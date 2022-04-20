class AddPasswordToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :password, :string
  end
end
