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
#  price                :integer          not null
#
class Flight < ApplicationRecord
  belongs_to :departing_airport, class_name: :Airport
  belongs_to :arriving_airport, class_name: :Airport
  
  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings

  scope :find_flights, -> params {
    includes(:departing_airport, :arriving_airport)
    .where(
      departing_airport_id: params[:departing_airport_id],
      arriving_airport_id: params[:arriving_airport_id],
      departure_date: params[:date]
    )
  }

  def duration_hours
    duration / 60
  end

  def duration_minutes
    duration % 60
  end

  def arrival_date_formatted
    departure_minutes = departure_time.hour * 60 + departure_time.min
    total_travel_minutes = departure_minutes + duration
    total_days = total_travel_minutes / 1440 # 1440 = total min in day
    (departure_date + total_days).strftime('%a, %b %-d')
  end

  def arrival_time_formatted
    (departure_time + duration_hours.hours + duration_minutes.minutes).strftime('%l:%M%P')
  end

  def departure_date_formatted
    departure_date.strftime('%a, %b %-d')
  end

  def departure_time_formatted
    departure_time.strftime('%l:%M%P')
  end
end
