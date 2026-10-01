class CreateStops < ActiveRecord::Migration[8.1]
  def change
    create_table :stops do |t|
      t.references :trip, null: false, foreign_key: true
      t.integer :stop_type
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.integer :status
      t.date :scheduled_at
      t.date :completed_at
      t.integer :package_count
      t.string :notes

      t.timestamps
    end
  end
end
