class CreateAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :alerts do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :username
      t.string :email
      t.integer :amount
      t.integer :numOfFailedPayments
      t.datetime :lastRejectionDate

      t.timestamps
    end
  end
end
