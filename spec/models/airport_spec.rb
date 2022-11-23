# == Schema Information
#
# Table name: airports
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Airport, type: :model do
  describe 'associations' do
    it { should have_many(:departing_flights).dependent(:destroy) }
    it { should have_many(:arriving_flights).dependent(:destroy) }
  end
end
