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

  describe "validations" do
    it "allows the three valid categories" do
      valid_categories = ['album', 'book', 'movie']
      valid_categories.each do |category|
        piece = Piece.new(title: "test", category: category)
        piece.valid?.must_equal true
      end
    end

    it "rejects invalid categories" do
      invalid_categories = ['cat', 'dog', 'phd thesis', 1337, nil]
      invalid_categories.each do |category|
        piece = Piece.new(title: "test", category: category)
        piece.valid?.must_equal false
        piece.errors.messages.must_include :category
      end
    end

    it "requires a title" do
      piece = Piece.new(category: 'ablum')
      piece.valid?.must_equal false
      piece.errors.messages.must_include :title
    end

    it "requires unique names w/in categories" do
      category = 'album'
      title = 'test title'
      piece1 = Piece.new(title: title, category: category)
      piece1.save!

      piece2 = Piece.new(title: title, category: category)
      piece2.valid?.must_equal false
      piece2.errors.messages.must_include :title
    end

    it "does not require a unique name if the category is different" do
      title = 'test title'
      piece1 = Piece.new(title: title, category: 'album')
      piece1.save!

      piece2 = Piece.new(title: title, category: 'book')
      piece2.valid?.must_equal true
    end
  end
end
