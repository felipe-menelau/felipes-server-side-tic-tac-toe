class StatsQueries < Match
  def self.query
    return "
      SELECT
        COUNT(*) AS total_games,
        COUNT(*) FILTER (WHERE winner = 'A') AS player_a_wins,
        COUNT(*) FILTER (WHERE winner = 'B') AS player_b_wins,
        COUNT(*) FILTER (WHERE winner = 'T') AS ties,
        COUNT(*) FILTER (WHERE winner IS NOT NULL) AS total_games_played,
        ROUND((COUNT(*) FILTER (WHERE winner = 'A')::float / COUNT(*) FILTER (WHERE winner IS NOT NULL)) * 100) AS player_a_win_rate,
        ROUND((COUNT(*) FILTER (WHERE winner = 'B')::float / COUNT(*) FILTER (WHERE winner IS NOT NULL)) * 100) AS player_b_win_rate
      FROM matches
      "
  end

  def self.exectue_query
    ActiveRecord::Base.connection.execute(query)
  end

  def execute_query
    ActiveRecord::Base.connection.execute(self.class.query)
  end
end
