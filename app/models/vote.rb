class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :piece

  validates :user, uniqueness: { scope: :piece }
end
