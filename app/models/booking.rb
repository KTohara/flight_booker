# == Schema Information
#
# Table name: bookings
#
#  id           :bigint           not null, primary key
#  flight_id    :bigint
#  passenger_id :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (flight_id => flights.id)
#  fk_rails_...  (passenger_id => users.id)
#
class Booking < ApplicationRecord
  belongs_to :passenger, class_name: :User
  belongs_to :flight
end
