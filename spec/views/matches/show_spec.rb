# spec/views/matches/show_spec.rb
require "rails_helper"

RSpec.describe "matches/show", type: :view do
  before(:each) do
    @match = assign(:match, FactoryBot.create(:match))
    @match.game_matrix = [["A", "B", "A"], ["B", "A", "B"], ["A", "B", "A"]]
  end

  it "renders the match" do
    render
    expect(rendered).to match(/New Game/)
  end

  it "displays the share link if the match is not over" do
    @match.winner = nil
    render
    expect(rendered).to match(/Send this link to your friend to play async multiplayer/)
  end

  it "displays a message if the match is over" do
    @match.winner = "A"
    render
    expect(rendered).to match(/Could you have won this...?/)
  end
end
