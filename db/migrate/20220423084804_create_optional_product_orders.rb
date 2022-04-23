class CreateOptionalProductOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :optional_product_orders do |t|
      t.references :optional_product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
