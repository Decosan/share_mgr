require 'rails_helper'

RSpec.describe "バリデーションの確認", type: :model do
  
  it 'nameが空欄の場合、User作成不可' do
    @user = User.new(name:'',email:'test@123.com',password:'123456')
    @user1 = User.new(name:'test',email:'test@123.com',password:'123456')
    expect(@user.valid?).to eq(false)
    expect(@user1.valid?).to eq(true)
  end

  it 'emailが重複している場合、User作成不可' do
    user2 = FactoryBot.create(:user, email: 'Test1@example.com')
    user3 = User.create(email: 'Test1@example.com')
    
    expect(user3.valid?).to eq(false)
    expect(user3.errors[:email]).to include("はすでに存在します")
  end
end