class Payment < ApplicationRecord
  belongs_to :user
  validate :payed_date_check

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
  enum payment_method: {
    "銀行振り込み": 0,
    "クレジット払い": 1,
  }

  def payed_date_check
    errors.add(:payed_date, "は未来の日時は登録できません") if
    self.payed_date > Date.today
  end
end
