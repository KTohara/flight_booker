require 'rails_helper'

RSpec.describe "routing", type: :routing do
  it 'routes correctly' do
    expect(get: 'flights').to route_to(controller: 'flights', action: 'index')
    expect(get: 'home').to route_to(controller: 'flights', action: 'home')
    expect(get: 'flights/1').not_to be_routable

    expect(get: 'bookings/new').to route_to(controller: 'bookings', action: 'new')
    expect(post: 'bookings').to route_to(controller: 'bookings', action: 'create')
    expect(get: 'bookings/1').to route_to(controller: 'bookings', action: 'show', id: '1')
    expect(get: 'bookings/1/edit').not_to be_routable
  end
end