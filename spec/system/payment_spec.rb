require 'rails_helper'

RSpec.describe "Payment", type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:user_admin) { FactoryBot.create(:user, admin: true) }

  before do
    user
    user_admin

    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "123456"
    click_on 'Log in'
    fill_in "姓（せい）", with: "たこ"
    fill_in "名（めい）", with: "大介"
    click_on '登録'
    click_on 'トップページ'
    click_on '家賃の管理'
    click_link '管理者に振り込みの報告を行う'
    find("input[name='payment[method]'][id='payment_method_銀行振り込み']").set(true)
    click_on '登録'
    click_on '送信'
  end

  context '正常系' do

    it '振り込み後報告を作成すると一覧に表示されること' do
      expect(page).to have_content '金額：30,000円 | 銀行振り込み'
    end

    it '振り込み報告を作成すると、管理者にメールが送信されること' do
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it '管理者が入金確認すると、確認済みメールが入居者に送られ、入居者のマイページに入金確認済みと表示されること' do
      click_on 'ログアウト'
      fill_in "メールアドレス", with: user_admin.email
      fill_in "パスワード", with: user_admin.password
      click_on 'Log in'
      click_on 'トップページ'
      click_on '家賃の管理'
      click_link '入金 Confirm'
      page.driver.browser.switch_to.alert.accept
      sleep 1
      expect(ActionMailer::Base.deliveries.count).to eq 2

      click_on 'ログアウト'
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on 'Log in'
      click_on 'トップページ'
      click_on '家賃の管理'
      sleep 1
      expect(page).to have_content '入金確認済み'
    end
  end

  context 'クレジットカード決済' do
    fit 'クレジットカード決済ができること' do
      click_link 'クレジットカードで決済する'
      fill_in "card_number", with: "5555555555554444"
      select '12', from: 'exp_month'
      select '22', from: 'exp_year'
      fill_in "cvc", with: "123"
      sleep 1
      click_on 'token_submit'
      sleep 2
      page.driver.browser.switch_to.alert.accept
      click_link '支払い画面へ'
      sleep 3
    end
  end
end
