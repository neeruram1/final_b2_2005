class Flight < ApplicationRecord
  validates_presence_of :number
  validates_presence_of :date
  validates_presence_of :time
  validates_presence_of :departure_city
  validates_presence_of :arrival_city 
end
