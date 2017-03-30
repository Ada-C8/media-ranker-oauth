class User < ApplicationRecord
  has_many :votes
  has_many :ranked_pieces, through: :votes, source: :piece

  validates :username, uniqueness: true, presence: true
end
