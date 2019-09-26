class User < ApplicationRecord
  has_one :personnel, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :routines, through: :assignments, source: :routine
  has_many :assignments, dependent: :destroy
  has_many :payments, dependent: :destroy
  validates :name, presence: true, length: {maximum: 30}
end
