class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :email
      t.boolean :isSolvent

      t.timestamps
    end
  end
end
