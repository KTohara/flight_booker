class PassengerMailer < ApplicationMailer
  def confirmation_email
    @booking = Booking.find(params[:booking_id])
    @flight = @booking.flight
    @user = @booking.user
    @url = booking_url(@booking)
    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "Flight Booker Confirmation"
    )
  end
end
