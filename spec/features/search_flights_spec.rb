require 'rails_helper'

RSpec.feature "Users can search flights" do
  let!(:user) { create(:user) }

  let!(:jfk) { create(:airport, :jfk) }
  let!(:lax) { create(:airport, :lax) }

  let!(:jfk_to_lax) { create(:short_duration_flight, departing_airport: jfk, arriving_airport: lax) }
  
  before do 
    login_as(user)
    visit flights_path
  end

  scenario "user inputs valid options" do
    visit flights_path
    select("New York City, NY", from: "airport_departing_airport_id")
    select("Los Angeles, CA", from: "airport_arriving_airport_id")
    select("1", from: "airport_passenger_count")
    fill_in("airport_date", with: Time.zone.today )
    click_on("Get Flights")

    expect(page).to have_content("JFK")
    expect(page).to have_content("LAX")
  end

  scenario "user does not input date" do
    select("New York City, NY", from: "airport_departing_airport_id")
    select("Los Angeles, CA", from: "airport_arriving_airport_id")
    select("1", from: "airport_passenger_count")
    click_on("Get Flights")

    expect(page).to have_content("Please pick a date")
  end

  scenario "user selects same airport" do
    select("New York City, NY", from: "airport_departing_airport_id")
    select("New York City, NY", from: "airport_arriving_airport_id")
    fill_in("airport_date", with: Time.zone.today)
    select("1", from: "airport_passenger_count")
    click_on("Get Flights")

    expect(page).to have_content("Please choose two different cities!")
  end
end