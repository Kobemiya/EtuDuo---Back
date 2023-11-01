require 'rails_helper'

RSpec.describe "Achievements", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/achievements/index"
      expect(response).to have_http_status(:success)
    end
  end

end
