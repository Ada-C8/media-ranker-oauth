class Piece < ApplicationRecord
  has_many :votes
  has_many :ranking_users, through: :votes, source: :user
end
