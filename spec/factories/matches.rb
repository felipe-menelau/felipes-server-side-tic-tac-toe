# spec/factories/matches.rb
FactoryBot.define do
  factory :match do
    current_player { ["A", "B"].sample }
    game_matrix { Array.new(3) { Array.new(3) } }
    winner { ["A", "B", "T"].sample } # Assumes winner can be nil
  end
end
