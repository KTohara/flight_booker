# Preview all emails at http://localhost:3000/rails/mailers/passenger
class PassengerPreview < ActionMailer::Preview
  def confirmation_email
    PassengerMailer.with(booking_id: Booking.first.id).confirmation_email
  end
end
