class CreatePackageValidities < ActiveRecord::Migration[6.1]
  def change
    create_table :package_validities do |t|
      t.references :product_package, null: false, foreign_key: true
      t.references :validity_period, null: false, foreign_key: true

      t.timestamps
    end
  end
end
