# spec/controllers/stats_controller_spec.rb
require "rails_helper"

RSpec.describe StatsController, type: :controller do
  before(:all) do
    100.times do
      FactoryBot.create(:match)
    end
  end

  describe "GET #index" do
    it "renders the index template as json" do
      get :index, format: :json

      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end
end
