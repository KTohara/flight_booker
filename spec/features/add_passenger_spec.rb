require 'rails_helper'

RSpec.feature 'Adding passengers after flight selection' do
  let!(:user) { create(:user) }

  let!(:jfk) { create(:airport, :jfk) }
  let!(:lax) { create(:airport, :lax) }

  let!(:jfk_to_lax) { create(:short_duration_flight, id: 1, departing_airport: jfk, arriving_airport: lax) }

  before do
    login_as(user)
    visit "bookings/new?flight_id=1&passenger_count=1"
  end

  scenario 'user input is valid' do
    fill_in('booking_passengers_attributes_0_name', with: 'Passenger Name')
    click_on('Complete Booking')
    within('div#passengers') { expect(page).to have_content('Passenger Name') }
  end

  scenario 'user input is invalid' do
    click_on('Complete Booking')
    expect(page).to have_content('Please fill in all passengers.')
  end
end
