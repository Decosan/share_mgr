require 'rails_helper'

RSpec.describe "User", type: :system do
  
  describe 'User登録' do
    context '正常系' do
      fit 'サインアップ後は個人情報登録画面へ遷移し、登録後はUser詳細画面で個人情報が正しく表示されること' do
        
        expect {
      visit new_user_registration_path
      fill_in "ユーザーID", with: "TEST"
      fill_in "メールアドレス", with: "test@123.com"
      fill_in "パスワード", with: "123456"
      fill_in "確認用パスワード", with: "123456"
      click_on 'Sign up'
      }.to change(User, :count).by(1)
        expect(current_path).to eq new_personnel_path
        fill_in "姓（せい）", with: "ざっく"
        fill_in "名（めい）", with: "じょんそん"
        select '男性', from: '性別'
        select "101b", from: '部屋番号'
        click_on '登録'
        expect(page).to have_content 'ざっく'
        expect(page).to have_content 'じょんそん'
      end

      fit '個人情報の登録を完了していない場合、他のページへは遷移できない' do
          expect {
        visit new_user_registration_path
        fill_in "ユーザーID", with: "TEST"
        fill_in "メールアドレス", with: "test@123.com"
        fill_in "パスワード", with: "123456"
        fill_in "確認用パスワード", with: "123456"
        click_on 'Sign up'
        }.to change(User, :count).by(1)
          expect(current_path).to eq new_personnel_path
          fill_in "姓（せい）", with: ""
          fill_in "名（めい）", with: ""
          click_on 'トップページ'
          expect(page).to have_selector 'h1', text: '個人情報を登録して下さい'
          click_on 'マイページ'
          expect(page).to have_selector 'h1', text: '個人情報を登録して下さい'
      end

      fit 'ユーザー情報を編集した場合、詳細画面で編集後の内容が表示されること' do
        user = FactoryBot.create(:user)
        visit new_user_session_path
        fill_in "メールアドレス", with: "TEST1@example.com"
        fill_in "パスワード", with: "123456"
        click_on 'Log in'
        fill_in "姓（せい）", with: "たこ"
        fill_in "名（めい）", with: "大介"
        click_on '登録'
        click_link 'Edit'
        fill_in "Name", with: "kuro"
        fill_in "Email", with: "kuro@123.com"
        click_on '編集を完了'
        expect(page).to have_content "kuro"
        expect(page).to have_content "kuro@123.com"
      end

      fit 'ユーザー情報を削除できること' do
        user = FactoryBot.create(:user)
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_on 'Log in'
        fill_in "姓（せい）", with: "たこ"
        fill_in "名（めい）", with: "大介"
        click_on '登録'
        click_link 'Dele'
        page.driver.browser.switch_to.alert.accept
        sleep 1
        expect(User.count).to eq 0
      end
    end
  end
end