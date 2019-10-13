FactoryBot.define do
  
  factory :issue do
    body { "危険です！" }
    user
  end
end