FactoryBot.define do
  
  factory :assignment do
    user
    routine
    condition {Date.today}
  end
end