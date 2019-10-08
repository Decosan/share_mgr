class Review < ApplicationRecord
  belongs_to :user
  has_many :assign_reviews, dependent: :destroy
  has_many :assignments, through: :assign_reviews, source: :assignment

end
