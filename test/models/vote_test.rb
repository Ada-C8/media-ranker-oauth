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

  describe "validations" do
    let (:user1) { User.new(username: 'chris') }
    let (:user2) { User.new(username: 'chris') }
    let (:piece1) { Piece.new(category: 'book', title: 'House of Leaves') }
    let (:piece2) { Piece.new(category: 'book', title: 'For Whom the Bell Tolls') }

    it "allows one user to vote for multiple pieces" do
      vote1 = Vote.new(user: user1, piece: piece1)
      vote1.save!
      vote2 = Vote.new(user: user1, piece: piece2)
      vote2.valid?.must_equal true
    end

    it "allows multiple users to vote for a piece" do
      vote1 = Vote.new(user: user1, piece: piece1)
      vote1.save!
      vote2 = Vote.new(user: user2, piece: piece1)
      vote2.valid?.must_equal true
    end

    it "doesn't allow the same user to vote for the same piece twice" do
      vote1 = Vote.new(user: user1, piece: piece1)
      vote1.save!
      vote2 = Vote.new(user: user1, piece: piece1)
      vote2.valid?.must_equal false
    end
  end
end
