require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
  end

  describe 'Relationships' do
    it {should have_many :passenger_flights}
    it {should have_many(:flights).through(:passenger_flights)}
  end

  describe "Methods" do
    before(:each) do
      @delta = Airline.create(name: "Delta")
      @jet_blue = Airline.create(name: "Jet Blue")
      @virgin = Airline.create(name: "Virgin Atlantic")
      @flight_1 = @delta.flights.create(number: 1, date: "08/03/2020", time: "5:00 PM", departure_city: "Denver", arrival_city: "Boston")
      @flight_2 = @jet_blue.flights.create(number: 2, date: "08/04/2020", time: "7:00 AM", departure_city: "Denver", arrival_city: "New York")
      @flight_3 = @virgin.flights.create(number: 4, date: "08/08/2020", time: "4:00 PM", departure_city: "Los Angeles", arrival_city: "Toronto")
      @jim = Passenger.create(name: "Jim Halpert", age: 30)

      PassengerFlight.create(flight: @flight_1, passenger: @jim)
      PassengerFlight.create(flight: @flight_2, passenger: @jim)
      PassengerFlight.create(flight: @flight_3, passenger: @jim)
    end

    it ".flight_numbers" do
      expect(@jim.flight_numbers).to eq([1, 2, 4])
    end
  end
end
