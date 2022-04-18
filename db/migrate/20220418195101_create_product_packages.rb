class CreateProductPackages < ActiveRecord::Migration[6.1]
  def change
    create_table :product_packages do |t|
      t.string :name
      t.references :price, null: false, foreign_key: true

      t.timestamps
    end
  end
end
