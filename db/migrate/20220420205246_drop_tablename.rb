class DropTablename < ActiveRecord::Migration[6.1]
  def change
    drop_table :prices
  end
end
