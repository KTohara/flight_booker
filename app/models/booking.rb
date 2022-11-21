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
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flight

  has_many :passengers, dependent: :destroy
  
  accepts_nested_attributes_for :passengers
end
