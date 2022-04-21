class RemoveColumnPriceFromProductPackages < ActiveRecord::Migration[6.1]
  def change
    remove_reference :product_packages, :price, foreign_key: true
  end
end
