require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :arrival_city}
    it {should validate_presence_of :departure_city}
    it {should validate_numericality_of :number}
    it {should validate_uniqueness_of :number}
  end

  describe 'Relationships' do
    it {should belong_to :airline}
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through(:passenger_flights)}
  end

  describe 'Methods' do
    before(:each) do
      @delta = Airline.create(name: "Delta")
      @flight_1 = @delta.flights.create(number: 1, date: "08/03/2020", time: "5:00 PM", departure_city: "Denver", arrival_city: "Boston")
      @jim = Passenger.create(name: "Jim Halpert", age: 30)
      @pam = Passenger.create(name: "Pam Beesly", age: 28)
      @stanley = Passenger.create(name: "Stanley Hudson", age: 45)
      @john = Passenger.create(name: "John Doe", age: 10)
      @sally = Passenger.create(name: "Sally Doe", age: 5)
      PassengerFlight.create(flight: @flight_1, passenger: @jim)
      PassengerFlight.create(flight: @flight_1, passenger: @pam)
      PassengerFlight.create(flight: @flight_1, passenger: @stanley)
      PassengerFlight.create(flight: @flight_1, passenger: @john)
      PassengerFlight.create(flight: @flight_1, passenger: @sally)
    end

    it ".adults_count" do
      expect(@flight_1.adults_count).to eq(3)
    end

    it ".minors_count" do
      expect(@flight_1.minors_count).to eq(2)
    end
  end
end
