class Label < ApplicationRecord
  has_many :event_labels, dependent: :destroy
  has_many :issue_labels, dependent: :destroy
end