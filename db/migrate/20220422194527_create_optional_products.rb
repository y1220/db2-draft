class CreateOptionalProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :optional_products do |t|
      t.string :name
      t.integer :monthly_fee

      t.timestamps
    end
  end
end
