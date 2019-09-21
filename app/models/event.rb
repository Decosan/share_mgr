class Event < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :event_labels, dependent: :destroy
  has_many :labels, through: :event_labels, source: :label
end
