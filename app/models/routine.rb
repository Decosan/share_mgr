class Routine < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments, source: :user

  enum condition: {
    "毎日/１週間": 0,
    "週イチ(水)/１週間": 1,
    "週イチ(日)/１週間": 2,
    "週２(月、木)/１週間": 3,
    "週２(火、金)/１週間": 4,
  }
  
end
