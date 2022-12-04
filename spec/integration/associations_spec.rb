require 'rails_helper'

RSpec.describe 'model associations' do
  # Airports
  let!(:jfk) { create(:airport, :jfk) }
  let!(:lax) { create(:airport, :lax) }
  let!(:atl) { create(:airport, :atl) }

  # Flights
  let!(:jfk_to_lax) { create(:morning_flight, departing_airport: jfk, arriving_airport: lax) }
  let!(:atl_to_jfk) { create(:morning_flight, departing_airport: atl, arriving_airport: jfk) }

  # Booking
  let!(:user_1_booking) { create(:booking, user: user_1, flight: jfk_to_lax) }
  let!(:user_2_booking) { create(:booking, user: user_2, flight: atl_to_jfk) }

  # Users
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }

  # Passengers
  let!(:pass_1) { create(:passenger, booking: user_1_booking) }
  let!(:pass_2) { create(:passenger, booking: user_1_booking) }
  let!(:pass_3) { create(:passenger, booking: user_2_booking) }

  describe 'airports' do
    it 'includes the correct departing flights' do
      expect(jfk.departing_flights).to include(jfk_to_lax)
      expect(atl.departing_flights).to include(atl_to_jfk)
    end

    it 'includes the correct arriving flights' do
      expect(jfk.arriving_flights).to include(atl_to_jfk)
      expect(lax.arriving_flights).to include(jfk_to_lax)
    end
  end

  describe 'flights' do
    it 'belongs to the right departing airport' do
      expect(jfk_to_lax.departing_airport).to be(jfk)
      expect(atl_to_jfk.departing_airport).to be(atl)
    end

    it 'belongs to the right arriving airport' do
      expect(jfk_to_lax.arriving_airport).to be(lax)
      expect(atl_to_jfk.arriving_airport).to be(jfk)
    end

    it 'includes the correct bookings' do
      expect(jfk_to_lax.bookings).to include(user_1_booking)
      expect(atl_to_jfk.bookings).to include(user_2_booking)
      expect(atl_to_jfk.bookings).not_to include(user_1_booking)
    end

    it 'includes the correct passengers' do
      expect(jfk_to_lax.passengers).to include(pass_1, pass_2)
      expect(atl_to_jfk.passengers).to include(pass_3)
      expect(atl_to_jfk.passengers).not_to include(pass_1, pass_2)
    end
  end

  describe 'bookings' do
    it 'belongs to the correct user' do
      expect(user_1_booking.user).to be(user_1)
      expect(user_2_booking.user).to be(user_2)
    end

    it 'belongs to the correct flight' do
      expect(user_1_booking.flight).to be(jfk_to_lax)
      expect(user_2_booking.flight).to be(atl_to_jfk)
    end

    it 'includes the correct passengers' do
      expect(user_1_booking.passengers).to include(pass_1, pass_2)
      expect(user_2_booking.passengers).to include(pass_3)
      expect(user_2_booking.passengers).not_to include(pass_1, pass_2)
    end
  end

  describe 'users' do
    it 'includes the correct bookings' do
      expect(user_1.bookings).to include(user_1_booking)
      expect(user_2.bookings).to include(user_2_booking)
      expect(user_1.bookings).not_to include(user_2_booking)
    end

    it 'includes the correct flights' do
      expect(user_1.flights).to include(jfk_to_lax)
      expect(user_2.flights).to include(atl_to_jfk)
      expect(user_1.flights).not_to include(atl_to_jfk)
    end
  end

  describe 'passengers' do
    it 'belongs to the correct bookings' do
      expect(pass_1.booking).to be(user_1_booking)
      expect(pass_2.booking).to be(user_1_booking)
      expect(pass_2.booking).not_to be(user_2_booking)
      expect(pass_3.booking).to be(user_2_booking)
    end
  end
end