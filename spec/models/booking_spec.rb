# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  flight_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:flight) }
    it { should have_many(:passengers).dependent(:destroy) }
    it { should accept_nested_attributes_for(:passengers) }
  end
end
