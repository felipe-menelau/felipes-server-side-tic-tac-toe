class Match < ApplicationRecord
  validates :current_player, presence: true
  validates :current_player, inclusion: { in: %(A, B, WA, WB), message: "%{value} is not a valid player" }
  after_update_commit { broadcast_update }

  attribute_list = [:current_player, :game_matrix, :winner]

  before_save do
    attribute_list.each do |att|
      if new_record?
        next
      else
        update_column(att, self.send(att))
      end
    end
  end

  def swap_player
    if self.current_player == "A"
      self.current_player = "B"
    else
      self.current_player = "A"
    end
  end

  def get_cell(row, col)
    self.game_matrix[row][col]
  end

  def check_winner
    current_player = self.current_player
    # Check rows
    self.game_matrix.each_with_index do |row, index|
      if row.all? { |cell| cell == current_player }
        self.winner = current_player
        self.game_matrix[index] = ["W#{current_player}", "W#{current_player}", "W#{current_player}"]
        return true
      end
    end

    # Check columns
    self.game_matrix.transpose.each_with_index do |col, index|
      if col.all? { |cell| cell == current_player }
        self.winner = current_player
        self.game_matrix.each { |row| row[index] = "W#{current_player}" }
        return true
      end
    end

    # Check diagonals
    if (0..2).all? { |i| self.game_matrix[i][i] == current_player }
      self.winner = current_player
      (0..2).each { |i| self.game_matrix[i][i] = "W#{current_player}" }
      return true
    end

    if (0..2).all? { |i| self.game_matrix[i][2 - i] == current_player }
      self.winner = current_player
      (0..2).each { |i| self.game_matrix[i][2 - i] = "W#{current_player}" }
      return true
    end

    return false
  end

  def move!(coordinate_x, coordinate_y)
    return "GAME OVER" unless self.winner == nil
    return "INVALID MOVE" if self.game_matrix[coordinate_x][coordinate_y] != ""
    self.game_matrix[coordinate_x][coordinate_y] = self.current_player
    if check_winner
      self.save
      return "Player #{self.current_player} wins!"
    end
    swap_player
    self.save!
  end
end
