class Passenger < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :age
  has_many :passenger_flights
end
