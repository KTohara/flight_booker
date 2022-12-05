require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }

  let!(:jfk) { create(:airport, :jfk) }
  let!(:lax) { create(:airport, :lax) }

  let!(:jfk_to_lax) { create(:morning_flight, departing_airport: jfk, arriving_airport: lax) }
  let!(:atl_to_jfk) { create(:evening_flight, departing_airport: jfk, arriving_airport: lax) }

  let!(:user_1_booking) { create(:booking, id: '1', user: user_1, flight: jfk_to_lax) }
  let!(:user_2_booking) { create(:booking, id: '2', user: user_2, flight: atl_to_jfk) }

  context 'when requesting GET /bookings' do
    scenario 'will redirect to login if user is not logged in' do
      get bookings_path

      expect(response.body).to redirect_to(new_user_session_path)
    end

    scenario 'shows the proper users bookings' do
      login_as(user_1)
      get bookings_path

      expect(response.body).to include('8:00am') # morning_flight
      expect(response.body).not_to include('7:00pm') # evening_flight
    end
  end

  context 'when requesting a booking that does not belong to the user' do
    scenario 'redirects to the root path' do
      login_as(user_1)
      get booking_path(user_2_booking)
      
      expect(response).to redirect_to(root_url)
      expect(flash[:alert]).to eq("These aren't the flights you are looking for!")
    end
  end
end
