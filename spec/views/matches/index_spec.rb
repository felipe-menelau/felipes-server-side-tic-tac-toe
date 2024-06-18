# spec/views/matches/index_spec.rb
require "rails_helper"

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:cat_seed, 1)
  end

  it "renders the cat image" do
    render
    expect(rendered).to match(/gato-1/)
  end

  it "renders the new game form" do
    render
    expect(rendered).to match(/action="\/matches"/)
    expect(rendered).to match(/New Game/)
  end

  it "renders the refresh cat picture button" do
    render
    expect(rendered).to match(/Refresh Cat Picture/)
  end
end
