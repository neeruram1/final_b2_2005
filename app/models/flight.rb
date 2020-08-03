class Flight < ApplicationRecord
  validates_presence_of :number
  validates_presence_of :date
  validates_presence_of :time
  validates_presence_of :departure_city
  validates_presence_of :arrival_city
  validates_uniqueness_of :number
  validates_numericality_of :number
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  def adults_count
    passengers.where("age > 18").count
  end

  def minors_count
    passengers.where("age < 18").count
  end
end
