class RemoveColumnIsSolventFromCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :isSolvent, :is_insolvent
  end
end
