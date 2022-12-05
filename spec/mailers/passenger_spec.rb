require "rails_helper"

RSpec.describe PassengerMailer, type: :mailer do
  let!(:user) { create(:user) }
  let!(:jfk) { create(:airport, :jfk) }
  let!(:lax) { create(:airport, :lax) }
  let!(:flight) { create(:morning_flight, arriving_airport: jfk, departing_airport: lax) }

  let!(:booking) { create(:booking, flight: flight, user: user) }

  let!(:passenger) { create(:passenger, booking: booking) }

  let!(:mail) { PassengerMailer.with(booking_id: booking.id).confirmation_email }

  it 'renders the headers' do
    expect(mail.subject).to eq('Flight Booker Confirmation')
    expect(mail.to).to include(user.email)
    expect(mail.from).to include('flightbooker.info@example.com')
  end

  it 'renders the body' do
    expect(mail.body.encoded).to include(user.username)
    expect(mail.body.encoded).to include(booking_url(booking))
    expect(mail.body.encoded).to include(flight.departing_airport.code)
    expect(mail.body.encoded).to include(flight.arriving_airport.code)
    expect(mail.body.encoded).to include(flight.departing_airport.location)
    expect(mail.body.encoded).to include(flight.arriving_airport.location)
    expect(mail.body.encoded).to include(passenger.name)
  end

  it 'sends the email' do
    expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'sends the email to the correct user' do
    mail.deliver_now
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
  end
end
