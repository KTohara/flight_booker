class FlightsController < ApplicationController
  def index
    @airports = Airport.all.order(:location)
    @available_flights = search_flights if params[:airport]
  end

  private

    def search_params
      params.require(:airport).permit(:departing_airport_id, :arriving_airport_id, :date, :passenger_count)
    end

    def search_flights
      if search_params[:departing_airport_id] == search_params[:arriving_airport_id]
        flash.now[:alert] = 'Please choose two different cities!'
        render :index
      elsif search_params[:date].blank?
        flash.now[:alert] = 'Please pick a date!'
        render :index
      else
        Flight.includes(:departing_airport, :arriving_airport).find_flights(search_params)
      end
    end
end
