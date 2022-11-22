class BookingsController < ApplicationController
  def show
    @booking = Booking.includes(:passengers).find(params[:id])
  end
  
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new
    @passenger_count = params[:passenger_count].to_i
    @passenger_count.times { @booking.passengers.build }
    @passenger_num = 1
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to @booking, notice: "Congratulations! You've booked your flight"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def booking_params
      params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name])
    end
end
