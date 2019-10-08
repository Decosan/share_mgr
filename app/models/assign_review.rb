class AssignReview < ApplicationRecord
  belongs_to :assignment
  belongs_to :review
end
