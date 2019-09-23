class Label < ApplicationRecord
  has_many :event_labels, dependent: :destroy

end