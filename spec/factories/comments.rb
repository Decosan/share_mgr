FactoryBot.define do
  factory :comment do
    content { "参加します！！" }
    event
    user
  end
end
