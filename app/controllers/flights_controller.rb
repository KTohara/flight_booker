class FlightsController < ApplicationController
  def index
    @airports = Airport.all

  end

  def tailwind

  end
end
