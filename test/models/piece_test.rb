require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  describe "relations" do
    it "has a list of votes" do
       thrill = pieces(:thrill)
       thrill.must_respond_to :votes
       thrill.votes.each do |vote|
         vote.must_be_kind_of Vote
       end
    end

    it "has a list of voting users" do
      thrill = pieces(:thrill)
      thrill.must_respond_to :ranking_users
      thrill.ranking_users.each do |user|
        user.must_be_kind_of User
      end
    end
  end
end
