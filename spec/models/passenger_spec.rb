# == Schema Information
#
# Table name: passengers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  booking_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'associations' do
    it { should belong_to(:booking) }
  end
end
