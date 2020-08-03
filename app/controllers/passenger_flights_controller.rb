class PassengerFlightsController < ApplicationController
  def create
    flight = Flight.find_by_number(params[:flight_number])
    PassengerFlight.create(flight_id: flight.id , passenger_id: params[:passenger_id])
    redirect_to "/passengers/#{params[:passenger_id]}"
  end
end
