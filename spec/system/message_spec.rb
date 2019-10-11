require 'rails_helper'

RSpec.describe "Message", type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:message) { FactoryBot.create(:message, user_id: user.id) }

  before do
    user
    other_user

    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "123456"
    click_on 'Log in'
    fill_in "姓（せい）", with: "たこ"
    fill_in "名（めい）", with: "大介"
    click_on '登録'
    click_on 'トップページ'
    click_on 'チャット・質問Box'
  end

  context '正常系' do

    it 'チャットルームでメッセージを表示できること' do
      click_link 'メッセージを送る'
      sleep 1
      fill_in 'message_body', with: 'ども(^o^)'
      click_on 'メッセージを送る'
      sleep 1
      expect(Message.count).to eq 1
      expect(page).to have_content 'ども(^o^)'
    end


  end
end