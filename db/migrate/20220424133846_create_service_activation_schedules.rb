class CreateServiceActivationSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :service_activation_schedules do |t|
      t.references :order, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.datetime :activation_date
      t.datetime :deactivation_date

      t.timestamps
    end
  end
end
