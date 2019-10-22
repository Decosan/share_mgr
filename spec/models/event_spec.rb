require 'rails_helper'

RSpec.describe "バリデーションの確認", type: :model, focus: true do
  
  it 'タイトルが空欄の場合、イベント作成不可' do
    user = FactoryBot.create(:user)
    event1 = FactoryBot.build(:event, title:'', user_id: user.id)
    event2 = FactoryBot.build(:event, user_id: user.id)
    expect(event1.valid?).to eq(false)
    expect(event2.valid?).to eq(true)
  end

  it '内容が空欄の場合、イベント作成不可' do
    user = FactoryBot.create(:user)
    event1 = FactoryBot.build(:event, content:'', user_id: user.id)
    event2 = FactoryBot.build(:event, user_id: user.id)
    expect(event1.valid?).to eq(false)
    expect(event2.valid?).to eq(true)
  end
end