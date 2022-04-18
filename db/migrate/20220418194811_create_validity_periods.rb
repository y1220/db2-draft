class CreateValidityPeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :validity_periods do |t|
      t.integer :period

      t.timestamps
    end
  end
end
