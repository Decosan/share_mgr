require 'rails_helper'

RSpec.describe "User", type: :system do
  
  describe 'User登録' do
    context '正常系' do
      it 'サインアップ後は個人情報登録画面へ遷移し、登録後はUser詳細画面へ遷移すること' do
        # TODO: ローカル変数ではなく let を使用してください
        expect {
      visit new_user_registration_path
      fill_in "ID名", with: "TEST"
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
        expect(page).to have_selector 'h1', text: 'User Profile'
      end

      fit '個人情報の登録を完了していない場合、他のページへは遷移できない' do
          expect {
        visit new_user_registration_path
        fill_in "ID名", with: "TEST"
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
          click_on 'トップページ'
          expect(current_path).to eq new_personnel_path
          click_on 'マイページ'
          expect(current_path).to eq new_personnel_path
      end
    end
  end
end