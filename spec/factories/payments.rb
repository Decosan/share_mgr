FactoryBot.define do
  
  factory :payment do
    amount { 1 }
    month { Date.today }
    payment_method { 0 }
    user
  end
end