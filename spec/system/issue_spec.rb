require 'rails_helper'

RSpec.describe "Issue", type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:label1) { FactoryBot.create(:label) }
  let(:label2) { FactoryBot.create(:label, title: '緊急情報') }
  let(:label3) { FactoryBot.create(:label, title: 'ハリケーン') }
  let(:issue1) { FactoryBot.create(:issue, user_id: user.id, label_ids: [label1.id,label2.id]) }
  let(:issue2) { FactoryBot.create(:issue, body: '台風が近づいています！', user_id: user.id, label_ids: [label2.id,label3.id]) }

  before do
    user
    label1
    label2
    label3
    issue1
    issue2

    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "123456"
    click_on 'Log in'
    fill_in "姓（せい）", with: "たこ"
    fill_in "名（めい）", with: "大介"
    click_on '登録'
    click_on 'トップページ'
    click_on '掲示板(ご意見・情報)'
  end

  context '正常系' do

    it '掲示板にイシューを投稿できること' do
      fill_in 'issue_body', with: 'ちょｗｗｗｗ'
      click_on '投稿する'
      expect(page).to have_content 'ちょｗｗｗｗ'
    end

    it 'イシューをタグ検索できること' do
      select 'ハリケーン', from: 'issue_label_ids'
      click_on '検索'
      sleep 1
      expect(page).to have_content '台風が近づいています！'
      expect(page).not_to have_content '危険です！'
    end
  end
end
