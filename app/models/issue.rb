class Issue < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :issue_labels, dependent: :destroy
  has_many :labels, through: :issue_labels, source: :label
  validates :body, presence: true, length: {maximum: 255}
end
