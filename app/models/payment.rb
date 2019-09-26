class Payment < ApplicationRecord
  belongs_to :user
  enum amount: {
    "30,000": 0,
    "35,000": 1,
    "40,000": 2,
    "45,000": 3,
  }
  enum status: {
    "未払い": 0,
    "支払い済み": 1,
  }
  enum confirm: {
    "未確認": 0,
    "確認済み": 1,
  }
end
