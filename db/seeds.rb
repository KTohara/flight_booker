# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def morning_departure
  Faker::Time.between_dates(from: Time.zone.today, to: Time.zone.today + 1, period: :morning)
end

def afternoon_departure
  Faker::Time.between_dates(from: Time.zone.today, to: Time.zone.today + 1, period: :afternoon)
end

def evening_departure
  Faker::Time.between_dates(from: Time.zone.today, to: Time.zone.today + 1, period: :evening)
end

def rand_duration
  rand(300..500)
end

def rand_price
  rand(150..400)
end

Airport.find_or_create_by(code: "ATL", location: "Atlanta, GA")
Airport.find_or_create_by(code: "LAX", location: "Los Angeles, CA")
Airport.find_or_create_by(code: "SFO", location: "San Francisco, CA")
Airport.find_or_create_by(code: "JFK", location: "New York City, NY")

airport_pairs = Airport.all.to_a.permutation(2)
start_date = Time.zone.today
end_date = Time.zone.today + 1.week

(start_date..end_date).each do |date|
  flights = Flight.where(departure_date: date)
  next if flights.count.positive?

  airport_pairs.each do |pair|
    departures = [morning_departure, afternoon_departure, evening_departure]
    departures.each do |time|
      Flight.create(
        departure_date: date,
        departure_time: time,
        duration: rand_duration,
        price: rand_price,
        departing_airport: pair.first,
        arriving_airport: pair.last
      )
    end
  end
end
