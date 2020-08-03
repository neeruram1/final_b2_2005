require 'rails_helper'

RSpec.describe 'Passenger show page' do
  before(:each) do
    @delta = Airline.create(name: "Delta")
    @jet_blue = Airline.create(name: "Jet Blue")
    @virgin = Airline.create(name: "Virgin Atlantic")
    @flight_1 = @delta.flights.create(number: 1, date: "08/03/2020", time: "5:00 PM", departure_city: "Denver", arrival_city: "Boston")
    @flight_2 = @jet_blue.flights.create(number: 2, date: "08/04/2020", time: "7:00 AM", departure_city: "Denver", arrival_city: "New York")
    @flight_3 = @virgin.flights.create(number: 4, date: "08/08/2020", time: "4:00 PM", departure_city: "Los Angeles", arrival_city: "Toronto")
    @flight_4 = @delta.flights.create(number: 3, date: "08/16/2020", time: "9:00 AM", departure_city: "London", arrival_city: "Tokyo")
    @jim = Passenger.create(name: "Jim Halpert", age: 30)

    PassengerFlight.create(flight: @flight_1, passenger: @jim)
    PassengerFlight.create(flight: @flight_2, passenger: @jim)
    PassengerFlight.create(flight: @flight_3, passenger: @jim)
  end

  it "I see that passenger's name and all flight details for that passenger" do
    visit passenger_path(@jim.id)

    expect(page).to have_content(@jim.name)

    within ".flight-#{@flight_1.id}" do
      expect(page).to have_content("Flight Number: #{@flight_1.number}")
      expect(page).to have_link(@flight_1.number)
    end

    within ".flight-#{@flight_2.id}" do
      expect(page).to have_content("Flight Number: #{@flight_2.number}")
      expect(page).to have_link(@flight_2.number)
    end

    within ".flight-#{@flight_3.id}" do
      expect(page).to have_content("Flight Number: #{@flight_3.number}")
      expect(page).to have_link(@flight_3.number)
      click_on "#{@flight_3.number}"
    end

    expect(current_path).to eq(flight_path(@flight_3.id))
  end

  it "I see a form to add a flight" do
    visit passenger_path(@jim.id)

    within '.add-flight-form' do
      expect(page).to have_content("Add a Flight For #{@jim.name}")
      fill_in 'Flight Number', with: @flight_4.number
      click_on 'Add Flight'
    end

    expect(current_path).to eq(passenger_path(@jim.id))

    within ".flight-#{@flight_4.id}" do
      expect(page).to have_content("Flight Number: #{@flight_4.number}")
      expect(page).to have_link(@flight_4.number)
    end
  end
end
