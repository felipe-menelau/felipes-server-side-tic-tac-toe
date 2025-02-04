# spec/views/matches/_match_spec.rb
require "rails_helper"

RSpec.describe "matches/_match", type: :view do
  before(:each) do
    @match = assign(:match, FactoryBot.create(:match))
    @match.game_matrix = [["A", "B", "A"], ["B", "A", "B"], ["A", "B", "A"]]
  end

  it "renders the turn tracker" do
    @match.winner = nil
    @match.game_matrix = [["", "B", "A"], ["", "A", "B"], ["A", "B", "A"]]
    render partial: "matches/match", locals: { match: @match }
    expect(rendered).to match("It's currently player")
  end

  it "renders the winning board if there is a winner" do
    @match.winner = "A"
    render partial: "matches/match", locals: { match: @match }
    expect(rendered).to match("has won the game!")
  end

  it "renders the tie board if the game is a tie" do
    @match.winner = "T"
    render partial: "matches/match", locals: { match: @match }
    expect(rendered).to match("It's a tie!")
  end
end
