class Piece < ApplicationRecord
  has_many :votes
  has_many :ranking_users, through: :votes, source: :user

  validates :category,  presence: true,
                        inclusion: { in: %w(album book movie) }

  validates :title, presence: true,
                    uniqueness: { scope: :category }

  def self.best_albums
    top_ten("album")
  end

  def self.best_books
    top_ten("book")
  end

  def self.best_movies
    top_ten("movie")
  end

  def self.top_ten(category)
    where(category: category).order(vote_count: :desc).limit(10)
  end
end
