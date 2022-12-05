class BookingsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @bookings = current_user.bookings
  end

  def show
    @booking = Booking.includes(:passengers).find_by(id: params[:id])

    unless @booking && @booking.user == current_user
      redirect_to root_path, alert: "These aren't the flights you are looking for!"
    end
  end
  
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new
    
    passenger_count = params[:passenger_count].to_i
    passenger_count.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    @flight = Flight.find(params[:booking][:flight_id])

    if @booking.save
      PassengerMailer.with(booking_id: @booking.id).confirmation_email.deliver_now
      redirect_to @booking, notice: "#{@booking.user.username.titleize}, your flight has been booked! Confirmation email has been sent."
    else
      flash.now[:alert] = 'Please fill in all passengers.'
      render :new, status: :unprocessable_entity
    end
  end

  private

    def booking_params
      params.require(:booking).permit(:flight_id, :user_id, passengers_attributes: [:id, :name])
    end
end
