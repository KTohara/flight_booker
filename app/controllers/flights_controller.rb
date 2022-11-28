class FlightsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def home
  end

  def index
    @airports = Airport.order(:location)
    return unless params[:airport]

    validate_search
    @available_flights = Flight.find_flights(search_params)
  end

  private

    def search_params
      params.require(:airport).permit(:departing_airport_id, :arriving_airport_id, :date, :passenger_count)
    end

    def validate_search
      if search_params[:departing_airport_id] == search_params[:arriving_airport_id]
        flash.now[:alert] = 'Please choose two different cities!'
        render :index
      elsif search_params[:passenger_count].blank?
        flash.now[:alert] = 'Please pick the amount of passengers!'
        render :index
      elsif search_params[:date].blank?
        flash.now[:alert] = 'Please pick a date!'
        render :index
      end
    end
end
