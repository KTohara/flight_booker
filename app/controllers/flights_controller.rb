class FlightsController < ApplicationController
  def index
    @airports = Airport.all
  end
end
