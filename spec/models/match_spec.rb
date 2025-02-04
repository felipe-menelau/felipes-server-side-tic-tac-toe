# spec/models/match_spec.rb
require "rails_helper"

RSpec.describe Match, type: :model do
  let!(:match) { FactoryBot.build(:match) }

  describe "validations" do
    it "validates presence of current_player" do
      match.current_player = nil
      expect { match.valid? }.to raise_error(TypeError)
    end

    it "validates inclusion of current_player" do
      match.current_player = "Z"
      expect(match).not_to be_valid
    end
  end

  describe "#swap_player" do
    it "swaps the current player" do
      match.current_player = "A"
      match.swap_player
      expect(match.current_player).to eq("B")
    end
  end

  describe "#get_cell" do
    it "returns the value of the cell at the given coordinates" do
      match.game_matrix = [["A", "B"], ["B", "A"]]
      expect(match.get_cell(0, 1)).to eq("B")
    end
  end

  describe "#check_winner" do
    context "when there is a winner" do
      it "returns true and sets the winner for row win" do
        match.game_matrix = [["A", "A", "A"], ["", "", ""], ["", "", ""]]
        match.current_player = "A"
        expect(match.check_winner).to be true
        expect(match.winner).to eq("A")
      end

      it "returns true and sets the winner for column win" do
        match.game_matrix = [["A", "", ""], ["A", "", ""], ["A", "", ""]]
        match.current_player = "A"
        expect(match.check_winner).to be true
        expect(match.winner).to eq("A")
      end

      it "returns true and sets the winner for diagonal win" do
        match.game_matrix = [["A", "", ""], ["", "A", ""], ["", "", "A"]]
        match.current_player = "A"
        expect(match.check_winner).to be true
        expect(match.winner).to eq("A")
      end
    end

    context "when there is no winner" do
      it "returns false and does not set the winner" do
        match.winner = nil
        match.game_matrix = [["A", "B", ""], ["B", "", ""], ["A", "", ""]]
        match.current_player = "A"
        expect(match.check_winner).to be false
        expect(match.winner).to be_nil
      end
    end
  end

  describe "#check_tie" do
    context "when there is a tie" do
      it 'returns true and sets the winner to "T"' do
        match.game_matrix = [["A", "B", "A"], ["B", "A", "B"], ["A", "B", "A"]]
        expect(match.check_tie).to be true
        expect(match.winner).to eq("T")
      end
    end

    context "when there is no tie" do
      it "returns false and does not set the winner" do
        match.winner = nil
        match.game_matrix = [["A", "", "A"], ["B", "A", "B"], ["A", "B", "A"]]
        expect(match.check_tie).to be false
        expect(match.winner).to be_nil
      end
    end
  end

  describe "#move!" do
    context "when the game is over" do
      it 'returns "GAME OVER"' do
        match.winner = "A"
        expect(match.move!(0, 0)).to eq("GAME OVER")
      end
    end

    context "when the move is invalid" do
      it 'returns "INVALID MOVE"' do
        match.game_matrix[0][0] = "A"
        match.winner = nil
        expect(match.move!(0, 0)).to eq("INVALID MOVE")
      end
    end

    context "when the move is valid" do
      it "updates the game matrix and checks for a winner" do
        match.current_player = "A"
        match.winner = nil
        match.game_matrix = [["", "A", ""], ["", "", ""], ["", "", ""]]
        expect(match.move!(0, 0)).to be_truthy
        expect(match.game_matrix[0][0]).to eq("A")
      end

      it 'returns "Player A wins!" if the move results in a win' do
        match.winner = nil
        match.game_matrix = [["A", "A", ""], ["", "", ""], ["", "", ""]]
        match.current_player = "A"
        expect(match.move!(0, 2)).to eq("Player A wins!")
      end

      it "checks for a tie if the move does not result in a win" do
        match.winner = nil
        match.game_matrix = [["C", "C", "C"], ["C", "C", "C"], ["C", "C", ""]]
        match.current_player = "B"
        expect(match.move!(2, 2)).to eq("It's a tie!")
      end
    end
  end
end
