class AddPriceToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :price, :integer, null: false
  end
end
