class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :routine
  has_many :assign_reviews, dependent: :destroy
  has_many :reviews, through: :assign_reviews, source: :review
end
