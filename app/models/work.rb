class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :ranking_users, through: :votes, source: :user

  validates :category,  presence: true,
                        inclusion: { in: %w(album book movie) }

  validates :title, presence: true,
                    uniqueness: { scope: :category }

  # This is called a model filter, and is very similar to a controller filter.
  # We want to fixup the category *before* we validate, because
  # our validations are rather strict about what's OK.
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
    if self.category
      self.category = self.category.downcase.singularize
    end
  end
end
