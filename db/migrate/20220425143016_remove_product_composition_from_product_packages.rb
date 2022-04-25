class RemoveProductCompositionFromProductPackages < ActiveRecord::Migration[6.1]
  def change
    remove_reference :product_packages, :product_composition, null: false, foreign_key: true
  end
end
