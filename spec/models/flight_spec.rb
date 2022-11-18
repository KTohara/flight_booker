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
require 'rails_helper'

RSpec.describe Flight, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
