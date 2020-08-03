class PassengerFlightsController < ApplicationController
  def create
    binding.pry
    flight = Flight.find_by_number(params[:flight_number])

    if flight.nil?
      redirect_to "/passengers/#{params[:passenger_id]}"
      flash[:error] = "Flight number can't be blank"
    else
      PassengerFlight.create(flight_id: flight.id , passenger_id: params[:passenger_id])
      redirect_to "/passengers/#{params[:passenger_id]}"
    end
  end
end
