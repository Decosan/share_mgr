require 'rails_helper'

RSpec.describe "Routine", type: :system, focus: true do
  
  let(:user) { FactoryBot.create(:user) }
  let(:routine) { FactoryBot.create(:routine) }
  

  before do
    user
    routine
    
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "123456"
    click_on 'Log in'
    fill_in "姓（せい）", with: "たこ"
    fill_in "名（めい）", with: "大介"
    click_on '登録'
    click_on 'トップページ'
    click_on '共同生活タスク'
    click_on routine.title
    click_on '新規アサイン'
    select user.name, from: '担当者'
    click_on '登録'
  end

  context '正常系' do

    it 'ルーティンタスクにユーザーをアサインすると詳細画面に表示されること' do
      sleep 1
      expect(page).to have_content user.name
    end

    it 'ルーティンタスクのアサインは編集・削除ができること' do
      click_link '変更する'
      select Date.today.day + 7, from: 'assignment[start_time(3i)]'
      click_on '登録'
      click_on '取り消す'
      page.driver.browser.switch_to.alert.accept
      sleep 1
      expect(Assignment.count).to eq 0
    end

    it '一覧ページに今週のタスクの担当者名が表示されること' do
      click_on 'タスク一覧へ'
      expect(page).to have_content user.name
    end

    it '期間終了したタスクは終了タスクを明示されること' do
      click_link '変更する'
      select Date.today.day - 7, from: 'assignment[start_time(3i)]'
      click_on '登録'
      expect(page).to have_content '終了しました'
    end
  end

  context '評価系' do

    it 'アサインに対して行った評価は、アサイン詳細で一覧表示されること' do
      click_link '評価する'
      sleep 1
      fill_in 'コメント', with: 'もうちょっと頑張って'
      click_on '投稿する'
      expect(page).to have_content 'もうちょっと頑張って'
    end

    it 'アサインに対して行った評価は、アサイン一覧で評価数・平均点が表示されること' do
      click_link '評価する'
      sleep 1
      fill_in 'コメント', with: 'もうちょっと頑張って'
      click_on '投稿する'
      expect(page).to have_content 'もうちょっと頑張って'
      click_link '戻る'
      expect(page).to have_content '1ケの評価 / 平均:0 点'
    end
  end
end 