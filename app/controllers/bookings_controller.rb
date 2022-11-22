class BookingsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @bookings = current_user.bookings
  end

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
    if @booking.save
      PassengerMailer.with(booking: @booking).confirmation_email.deliver_now!
      redirect_to @booking, notice: "Your flight has been booked! Confirmation email has been sent."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def booking_params
      params.require(:booking).permit(:flight_id, :user_id, passengers_attributes: [:id, :name])
    end
end
