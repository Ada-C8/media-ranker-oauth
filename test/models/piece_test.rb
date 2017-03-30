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

  describe "votes_count" do
    it "defaults to 0" do
      piece = Piece.create!(title: "test title", category: "movie")
      piece.must_respond_to :votes_count
      piece.votes_count.must_equal 0
    end

    it "tracks the number of votes" do
      piece = Piece.create!(title: "test title", category: "movie")
      4.times do |i|
        user = User.create!(username: "user#{i}")
        Vote.create!(user: user, piece: piece)
      end
      piece.votes_count.must_equal 4
    end
  end

  describe "top_ten" do
    before do
      # TODO DPR: This runs pretty slow. Fixtures?
      # Create users to do the voting
      test_users = []
      20.times do |i|
        test_users << User.create!(username: "user#{i}")
      end

      # Create media to vote upon
      8.times do |i|
        piece = Piece.create!(category: "movie", title: "test movie #{i}")
        vote_count = rand(test_users.length)
        test_users.first(vote_count).each do |user|
          Vote.create!(piece: piece, user: user)
        end
      end
    end

    it "returns a list of media of the correct category" do
      movies = Piece.top_ten("movie")
      movies.length.must_equal 8
      movies.each do |movie|
        movie.must_be_kind_of Piece
        movie.category.must_equal "movie"
      end
    end

    it "orders media by vote count" do
      movies = Piece.top_ten("movie")
      previous_vote_count = 100
      movies.each do |movie|
        movie.votes_count.must_be :<=, previous_vote_count
        previous_vote_count = movie.votes_count
      end
    end

    it "returns at most 10 items" do
      movies = Piece.top_ten("movie")
      movies.length.must_equal 8

      Piece.create(title: "phase 2 test movie 1", category: "movie")
      Piece.top_ten("movie").length.must_equal 9

      Piece.create(title: "phase 2 test movie 2", category: "movie")
      Piece.top_ten("movie").length.must_equal 10

      Piece.create(title: "phase 2 test movie 3", category: "movie")
      Piece.top_ten("movie").length.must_equal 10
    end
  end
end
