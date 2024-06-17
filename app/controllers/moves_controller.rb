class MovesController < ApplicationController
  def create
    @match = Match.find(params[:match_id])
    @match.move!(params[:row].to_i, params[:col].to_i)

    respond_to do |format|
      format.turbo_stream
      format.html {
        redirect_to @match
      }
    end
  end
end
