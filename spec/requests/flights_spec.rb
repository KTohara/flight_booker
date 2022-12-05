require 'rails_helper'

RSpec.describe "Flights", type: :request do
  context 'when user is not logged in' do
    scenario 'GET /flights redirects to sign in' do
      get flights_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end