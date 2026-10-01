class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.references :route, null: false, foreign_key: true
      t.string :driver_name
      t.string :vehicule_plate
      t.integer :status
      t.date :scheduled_date

      t.timestamps
    end
  end
end
