class PassengerMailer < ApplicationMailer
  def confirmation_email
    @booking = params[:booking]
    @user = @booking.user
    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "Flight Booker Confirmation"
    )
  end
end
