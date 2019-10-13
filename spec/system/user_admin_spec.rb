require 'rails_helper'

RSpec.describe "Admin", type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:personnel) { FactoryBot.create(:personnel, user_id: user.id) }
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let(:payment) { FactoryBot.create(:payment, user_id: user.id) }

  before do
    user
    personnel
    admin_user
    payment
    
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
      click_on '管理者権限を与える'
      click_on 'ログアウト'
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on 'Log in'
      click_on 'マイページ'
      expect(page).to have_selector 'h2', text: '管理者：'
    end

    fit '管理者ユーザーは管理ページで全テーブルのCRUD処理が可能なこと' do
      click_on '管理者ページへ'
      expect(page).to have_selector 'h1', text: 'サイト管理'
    end

    fit '管理者ユーザー以外は管理ページへ遷移できないこと' do
      click_on 'ログアウト'
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on 'Log in'
      expect(page).not_to have_content '管理者ページへ'
    end
  end
end