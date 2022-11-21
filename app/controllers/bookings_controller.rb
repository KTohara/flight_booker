class BookingsController < ApplicationController
  def show
  end
  
  def new
    debugger
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new
    @passenger_count = params[:passenger_count].to_i
    @passenger_count.times { @booking.passengers.build }
    @passenger_num = 1
  end

  def create
    @booking = Booking.new
  end

  private

    def booking_params
      params.require(:booking).permit()
    end
end
