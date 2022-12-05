require 'rails_helper'

RSpec.feature "Sorts flights based on selection" do
  let!(:user) { create(:user) }

  let!(:jfk) { create(:airport, :jfk) }
  let!(:lax) { create(:airport, :lax) }

  before do
    login_as(user)
    visit flights_path
  end

  context "when user selects duration" do
    let!(:long_dur) { create(:long_duration_flight, departing_airport: jfk, arriving_airport: lax) }
    let!(:short_dur) { create(:short_duration_flight, departing_airport: jfk, arriving_airport: lax) }
    let!(:medium_dur) { create(:medium_duration_flight, departing_airport: jfk, arriving_airport: lax) }

    scenario "will sort flights by duration", js: true do
      select("New York City, NY", from: "airport_departing_airport_id")
      select("Los Angeles, CA", from: "airport_arriving_airport_id")
      select("1", from: "airport_passenger_count")
      fill_in("airport_date", with: Time.zone.today)
      click_on("Get Flights")

      expect(page).to have_text /3 hours.*1 hour.*2 hours/m
      select("Duration", from: "airport_sort")
      sleep 0.1
      expect(page).to have_text /1 hour.*2 hours.*3 hours/m
    end
  end

  context "when user selects duration, then time" do
    let!(:afternoon) { create(:afternoon_flight, departing_airport: jfk, arriving_airport: lax) }
    let!(:evening) { create(:evening_flight, departing_airport: jfk, arriving_airport: lax) }
    let!(:morning) { create(:morning_flight, departing_airport: jfk, arriving_airport: lax) }
    
    scenario "will sort flights by time", js: true do
      select("New York City, NY", from: "airport_departing_airport_id")
      select("Los Angeles, CA", from: "airport_arriving_airport_id")
      select("1", from: "airport_passenger_count")
      fill_in("airport_date", with: Time.zone.today)
      click_on("Get Flights")

      select("Duration", from: "airport_sort")
      sleep 0.1
      expect(page).to have_text /2:00pm.*7:00pm.*8:00am/m
      select("Departure", from: "airport_sort")
      sleep 0.1
      expect(page).to have_text /8:00am.*2:00pm.*7:00pm/m
    end
  end

  context "when user selects price" do
    let!(:mid_price) { create(:mid_price_flight, departing_airport: jfk, arriving_airport: lax) }
    let!(:hi_price) { create(:high_price_flight, departing_airport: jfk, arriving_airport: lax) }
    let!(:low_price) { create(:low_price_flight, departing_airport: jfk, arriving_airport: lax) }
    
    scenario "will sort flights by price", js: true do
      select("New York City, NY", from: "airport_departing_airport_id")
      select("Los Angeles, CA", from: "airport_arriving_airport_id")
      select("1", from: "airport_passenger_count")
      fill_in("airport_date", with: Time.zone.today)
      click_on("Get Flights")

      expect(page).to have_text /300.*400.*200/m
      select("Price", from: "airport_sort")
      sleep 0.1
      expect(page).to have_text /200.*300.*400/m
    end
  end
end
