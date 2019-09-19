class User < ApplicationRecord
  has_one :personal_data, dependent: :destroy
  has_one_attached :avatar
  has_secure_password
  before_validation {email.downcase!}
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
