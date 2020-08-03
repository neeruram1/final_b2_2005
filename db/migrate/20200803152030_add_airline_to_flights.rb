class AddAirlineToFlights < ActiveRecord::Migration[5.1]
  def change
    add_reference :flights, :airline, foreign_key: true
  end
end
