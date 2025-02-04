class StatsController < ApplicationController
  def index
    @stats = StatsQueries.exectue_query.first
  end
end
