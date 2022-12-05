require 'rails_helper'

RSpec.describe "add booking", type: :system do
  let!(:jfk) { create(:airport, :jfk) }
  let!(:atl) { create(:airport, :atl) }
  let!(:lax) { create(:airport, :lax) }

  let!(:morning) { create(:morning_flight, id: 1, departing_airport: jfk, arriving_airport: lax) }
  let!(:afternoon) { create(:afternoon_flight, id: 2, departing_airport: jfk, arriving_airport: lax) }
  let!(:evening) { create(:evening_flight, id: 3, departing_airport: atl, arriving_airport: jfk) }

  it 'allows user to login, search/select flights, create a booking' do
    # Sign up
    visit '/'
    click_on('Sign in to book a flight')
    click_on('Sign Up')
    fill_in(:user_username, with: 'Example User')
    fill_in(:user_email, with: 'test@example.com')
    fill_in(:user_password, with: 'password')
    fill_in(:user_password_confirmation, with: 'password')
    click_on('Sign up')
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Departing from?')
    expect(page).to have_content('Going to?')
    expect(page).to have_content('Passengers')

    # Flight option selection
    select('New York City, NY', from: :airport_departing_airport_id)
    select('Los Angeles, CA', from: :airport_arriving_airport_id)
    select('2', from: :airport_passenger_count)
    fill_in(:airport_date, with: Time.zone.today)
    click_on('Get Flights')
    expect(page).to have_content('JFK').twice
    expect(page).to have_content('LAX').twice
    expect(page).to have_content('8:00am')
    expect(page).to have_content('2:00pm')
    expect(page).not_to have_content('ATL')
    expect(page).not_to have_content('7:00pm')

    # Booking options
    page.click_link('', href: '/bookings/new?flight_id=1&passenger_count=2')
    fill_in(:booking_passengers_attributes_0_name, with: 'Passenger One')
    fill_in(:booking_passengers_attributes_1_name, with: 'Passenger Two')
    click_on('Complete Booking')
    expect(page).to have_content('Example User, your flight has been booked!')
    expect(page).to have_content('JFK')
    expect(page).to have_content('LAX')
    expect(page).to have_content('Passenger One')
    expect(page).to have_content('Passenger Two')

    # 'My Flights'
    click_on('My Flights')
    expect(page).to have_content('JFK')
    expect(page).to have_content('LAX')

    # Show flight
    page.click_link('', href: "/bookings/#{Booking.first.id}")
    expect(page).to have_content('JFK')
    expect(page).to have_content('LAX')
    expect(page).to have_content('Passenger One')

    # Sign out
    click_on('Sign out')
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('SIGN IN TO BOOK A FLIGHT')
  end
end