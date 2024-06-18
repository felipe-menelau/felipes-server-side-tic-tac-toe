# spec/controllers/matches_controller_spec.rb
require "rails_helper"

RSpec.describe MatchesController, type: :controller do
  let!(:match) { FactoryBot.create(:match) }

  describe "GET #index" do
    it "assigns all matches as @matches" do
      get :index
      expect(assigns(:matches)).to eq(Match.all)
    end
  end

  describe "GET #show" do
    it "assigns the requested match as @match" do
      get :show, params: { id: match.id }
      expect(assigns(:match)).to eq(match)
    end
  end

  describe "GET #random" do
    it "assigns a random match as @match and redirects to it" do
      get :random
      expect(assigns(:match)).to be_a(Match)
      expect(response).to redirect_to(assigns(:match))
    end
  end

  describe "POST #create" do
    it "creates a new Match and redirects to it" do
      expect {
        post :create
      }.to change(Match, :count).by(1)

      expect(response).to redirect_to(Match.last)
    end
  end

  describe "POST #move" do
    it "makes a move in the match and assigns the match as @match" do
      post :move, params: { match_id: match.id, row: 0, col: 0 }
      expect(assigns(:match)).to eq(match)
    end
  end

  describe "GET #cat" do
    it "refreshes the cat seed and redirects to index" do
      get :cat
      expect(assigns(:cat_seed)).to be_between(1, 6).inclusive
      expect(response).to redirect_to(action: "index")
    end
  end

  describe "GET #new_game" do
    it "redirects to create action" do
      get :new_game
      expect(response).to redirect_to(action: "create")
    end
  end
end
