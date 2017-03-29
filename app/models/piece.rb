class Piece < ApplicationRecord
  has_many :votes
  has_many :ranking_users, through: :votes, source: :user

  validates :category,  presence: true,
                        inclusion: { in: %w(album book movie) }

  validates :title, presence: true,
                    uniqueness: { scope: :category }
end
