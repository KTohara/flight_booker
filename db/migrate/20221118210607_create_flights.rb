class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.date :departure_date,   null: false
      t.time :departure_time,   null: false
      t.integer :duration,      null: false
      t.references :departing_airport, index: true, foreign_key: { to_table: :airports }
      t.references :arriving_airport, index: true, foreign_key: { to_table: :airports }

      t.timestamps
    end
  end
end
