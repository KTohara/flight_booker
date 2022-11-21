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
class Airport < ApplicationRecord
  has_many :departing_flights,
    class_name: :Flight,
    foreign_key: :departing_airport_id,
    dependent: :destroy
  has_many :arriving_flights,
    class_name: :Flight,
    foreign_key: :arriving_airport_id,
    dependent: :destroy

  def info
    "#{code} - #{location}"
  end
end
