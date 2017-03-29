require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  describe "relations" do
    it "has a user" do
      v = votes(:one)
      v.must_respond_to :user
      v.user.must_be_kind_of User
    end

    it "has a piece" do
      v = votes(:one)
      v.must_respond_to :piece
      v.piece.must_be_kind_of Piece
    end
  end
end
