class PassengerMailer < ApplicationMailer
  def confirmation_email
    @booking = params[:booking]
    @flight = @booking.flight
    @user = @booking.user
    @url = booking_url(@booking)
    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "Flight Booker Confirmation"
    )
  end
end
