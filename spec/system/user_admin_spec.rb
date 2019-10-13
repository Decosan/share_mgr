require 'rails_helper'

RSpec.describe "Admin", type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  

  before do
    user
    admin_user
    
    visit new_user_session_path
    fill_in "メールアドレス", with: admin_user.email
    fill_in "パスワード", with: "123456"
    click_on 'Log in'
    
  end

  context '正常系' do

    it '管理者ユーザーは個人情報入力不要でユーザー一覧へ遷移のこと' do
      expect(current_path).to eq root_path
    end

    it '管理者ユーザーは他のユーザーにユーザー権限を譲与できること' do
      expect(current_path).to eq root_path
      click_link '管理者権限を与える'
      click_on 'ログアウト'
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on 'Log in'
      
    end

    it '管理者ユーザーは他のユーザーの振り込み報告書に対して、確認済みの回答してメールを返信できること' do
    end
  end
end