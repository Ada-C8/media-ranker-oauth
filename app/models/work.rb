class Work < ApplicationRecord
  has_many :votes
  has_many :ranking_users, through: :votes, source: :user

  validates :category,  presence: true,
                        inclusion: { in: %w(album book movie) }

  validates :title, presence: true,
                    uniqueness: { scope: :category }

  before_validation :fix_category

  def self.by_category(category)
    category = category.singularize.downcase
    self.where(category: category)
  end

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

private
  def fix_category
    self.category = self.category.downcase.singularize
  end
end
