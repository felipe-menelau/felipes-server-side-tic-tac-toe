class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])
  end

  def create
    @match = Match.create(current_player: "A", game_matrix: [["", "", ""], ["", "", ""], ["", "", ""]], winner: nil)
    redirect_to @match
  end
end
