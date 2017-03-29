require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe "relations" do
    it "has a list of votes" do
      dan = users(:dan)
      dan.must_respond_to :votes
      dan.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it "has a list of ranked pieces" do
      dan = users(:dan)
      dan.must_respond_to :ranked_pieces
      dan.ranked_pieces.each do |piece|
        piece.must_be_kind_of Piece
      end
    end
  end
end
