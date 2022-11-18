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
require 'rails_helper'

RSpec.describe Booking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
