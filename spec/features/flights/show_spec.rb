require 'rails_helper'

RSpec.describe 'Flight show page' do
  before(:each) do
    @delta = Airline.create(name: "Delta")
    @flight_1 = @delta.flights.create(number: 1, date: "08/03/2020", time: "5:00 PM", departure_city: "Denver", arrival_city: "Boston")
    @jim = Passenger.create(name: "Jim Halpert", age: 30)
    @pam = Passenger.create(name: "Pam Beesly", age: 28)
    @stanley = Passenger.create(name: "Stanley Hudson", age: 45)
    PassengerFlight.create(flight: @flight_1, passenger: @jim)
    PassengerFlight.create(flight: @flight_1, passenger: @pam)
    PassengerFlight.create(flight: @flight_1, passenger: @stanley)
  end

  it "I see all of the flight information" do
    visit "/flights/#{@flight_1.id}"
    expect(page).to have_content("Flight Number: #{@flight_1.number}")
    expect(page).to have_content("Flight Date: #{@flight_1.date}")
    expect(page).to have_content("Flight Time: #{@flight_1.time}")
    expect(page).to have_content("Departure City: #{@flight_1.departure_city}")
    expect(page).to have_content("Arrival City: #{@flight_1.arrival_city}")
  end

  it "I see the name of the airline this flight belongs to" do
    visit "/flights/#{@flight_1.id}"
    expect(page).to have_content(@delta.name)
  end

  it "I see the names of all the passengers on this flight" do
    visit "/flights/#{@flight_1.id}"
    
    within ".passengers" do
      expect(page).to have_content(@jim.name)
      expect(page).to have_content(@pam.name)
      expect(page).to have_content(@stanley.name)
    end
  end
end
