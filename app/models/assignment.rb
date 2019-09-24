class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :routine

  validates :start_time, presence: true
end
