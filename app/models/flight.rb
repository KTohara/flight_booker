# == Schema Information
#
# Table name: flights
#
#  id                   :bigint           not null, primary key
#  departure_date       :date             not null
#  departure_time       :time             not null
#  duration             :integer          not null
#  departing_airport_id :bigint
#  arriving_airport_id  :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (arriving_airport_id => airports.id)
#  fk_rails_...  (departing_airport_id => airports.id)
#
class Flight < ApplicationRecord
  belongs_to :departing_airport, class_name: :Airport
  belongs_to :arriving_airport, class_name: :Airport
  
  has_many :bookings
  has_many :flights, through: :bookings, source: :flight
  has_many :passengers, through: :bookings

  scope :find_flights, -> params {
    where(
      departing_airport_id: params[:departing_airport_id],
      arriving_airport_id: params[:arriving_airport_id],
      departure_date: params[:date]
    ) 
  }
end
