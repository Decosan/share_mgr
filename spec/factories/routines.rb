FactoryBot.define do
  
  factory :routine do
    title { 'ゴミ出し' }
    content { '台所のゴミ箱の管理' }
    condition {"毎日/１週間"}
  end
end