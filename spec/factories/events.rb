FactoryBot.define do
  
  factory :event do
    sequence(:title) { |n| "TEST_EVENT#{n}"}
    sequence(:content) { |n| "TEST_CONTENT#{n}"}
    sequence(:start_date, Date.today)
    user
  end
end