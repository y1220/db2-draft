class AddColumnPackageCompositionToProductPackages < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_packages, :product_composition, foreign_key: true
  end
end
