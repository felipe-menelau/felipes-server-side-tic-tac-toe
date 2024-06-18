class MatchesController < ApplicationController
  before_action :refresh_cat_seed, only: [:index]
  before_action :set_match, only: [:show, :move]

  def index
    @matches = Match.all
  end

  def show
  end

  def random
    @match = Match.where.not(winner: nil).order("RANDOM()").first
    redirect_to @match
  end

  def create
    @match = Match.new(current_player: "A", game_matrix: [["", "", ""], ["", "", ""], ["", "", ""]], winner: nil)

    if @match.save
      redirect_to @match
    else
      Rails.logger.error @match.errors.full_messages
      render :index
    end
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

  def set_match
    @match = Match.find_by(id: match_params[:id]) || Match.find_by(id: match_params[:match_id])
  end

  def match_params
    params.permit(:id, :match_id)
  end
end
