class MatchesController < ApplicationController
  before_action :refresh_cat_seed, only: [:index]

  def index
    @matches = Match.all
  end

  def show
    @match ||= Match.find(params[:id])
    @match ||= Match.find(params[:match_id])
    respond_to do |format|
      format.html
    end
  end

  def random
    @match = Match.where.not(winner: nil).order("RANDOM()").first
    redirect_to @match
  end

  def create
    @match = Match.create(current_player: "A", game_matrix: [["", "", ""], ["", "", ""], ["", "", ""]], winner: nil)
    redirect_to @match
  end

  def move
    @match = Match.find(params[:match_id])
    @match.move!(params[:row].to_i, params[:col].to_i)

    respond_to do |format|
      format.turbo_stream
      format.html {
        redirect_to @match
      }
    end
  end

  def cat
    refresh_cat_seed
    respond_to do |format|
      format.turbo_stream
      format.html {
        redirect_to action: "index"
      }
    end
  end

  def new_game
    redirect_to action: "create"
  end

  private

  def refresh_cat_seed
    @cat_seed = rand(1..6)
  end
end
