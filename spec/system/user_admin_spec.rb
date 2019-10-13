require 'rails_helper'

RSpec.describe "Admin", type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let(:payment) { FactoryBot.create(:payment, user_id: user.id) }

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
      click_on '管理者権限を与える'
      click_on 'ログアウト'
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on 'Log in'
      click_on 'マイページ'
      expect(page).to have_selector 'h2', text: '管理者：'
    end

    fit '管理者ユーザーは他の全てのユーザーの振り込み報告書を閲覧でき、それらに対し入金確認済みのメールを返信できること' do
      click_on 'トップページ'
      click_on '家賃の管理'
      sleep 2
      click_on '入金 Confirm'
      sleep 2
      expect(page).to have_content "入金確認ずみ"
    end

    it '管理者ユーザーは管理ページで全テーブルのCRUD処理が可能なこと' do

    end
  end
end