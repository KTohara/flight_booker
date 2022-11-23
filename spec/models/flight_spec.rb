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
require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'associations' do
    it { should belong_to(:departing_airport) }
    it { should belong_to(:arriving_airport) }
    it { should have_many(:bookings).dependent(:destroy) }
    it { should have_many(:passengers).through(:bookings) }
  end
end
