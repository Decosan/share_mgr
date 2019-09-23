class Event < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :event_labels, dependent: :destroy
  has_many :labels, through: :event_labels, source: :label
  has_many :comments, dependent: :destroy
  has_many :user_events, dependent: :destroy

  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 255}
  
end
