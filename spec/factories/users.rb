FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
