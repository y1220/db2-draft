class CreateProductCompositions < ActiveRecord::Migration[6.1]
  def change
    create_table :product_compositions do |t|
      t.references :product_package, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
