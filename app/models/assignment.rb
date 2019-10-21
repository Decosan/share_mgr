class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :routine
  has_many :assign_reviews, dependent: :destroy
  has_many :reviews, through: :assign_reviews, source: :review
  validate :start_time_check

  def start_time_check
    errors.add(:start_time, "の日付が正しくありません。") if
    self.start_time < Date.today
  end
end
