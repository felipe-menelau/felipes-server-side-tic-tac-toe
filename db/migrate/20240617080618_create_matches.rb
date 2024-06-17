class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.string :current_player
      t.string :game_matrix, array: true
      t.string :winner

      t.timestamps
    end
  end
end
