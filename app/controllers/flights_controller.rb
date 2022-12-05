class FlightsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def home
    redirect_to flights_path if user_signed_in?
  end

  def index
    @airports = Airport.order(:location)
    return unless params[:airport]

    validate_search
    @available_flights = Flight.find_flights(search_params).order(:departure_time)
    @sort_options = %i[Departure Price Duration]
    @available_flights = sort_flights if params[:airport][:sort]
  end

  private

    def search_params
      params.require(:airport).permit(:departing_airport_id, :arriving_airport_id, :date, :passenger_count, :price, :sort)
    end

    def validate_search
      if search_params[:departing_airport_id] == search_params[:arriving_airport_id]
        flash.now[:alert] = 'Please choose two different cities!'
        render :index
      end
    end
    
    def sort_flights
      case params[:airport][:sort]
      when 'Duration'
        Flight.find_flights(search_params).order(:duration)
      when 'Departure'
        Flight.find_flights(search_params).order(:departure_time)
      when 'Price'
        Flight.find_flights(search_params).order(:price)
      end
    end
end
