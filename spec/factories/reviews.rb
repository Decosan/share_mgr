FactoryBot.define do
  factory :review do
    sequence(:content) { |n| "Excellent#{n}"}
    rate { 4.5 }
    user
  end
end
