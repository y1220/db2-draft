class CreatePackageOptionals < ActiveRecord::Migration[6.1]
  def change
    create_table :package_optionals do |t|
      t.references :product_package, null: false, foreign_key: true
      t.references :optional_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
