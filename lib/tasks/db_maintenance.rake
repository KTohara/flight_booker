namespace :db do
  desc "Destroy past to keep database current"
  task destroy_past_flights: :environment do
    past_flights = Flight.where('departure_date <= ?', Time.zone.yesterday)
    past_flights.destroy_all
  end
end
