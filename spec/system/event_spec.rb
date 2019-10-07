require 'rails_helper'

RSpec.describe "Event", type: :system do

  describe 'Event登録' do
    context '正常系' do

      before do

        user = FactoryBot.create(:user)
        visit new_user_session_path
        fill_in "メールアドレス", with: "TEST1@example.com"
        fill_in "パスワード", with: "123456"
        click_on 'Log in'
        fill_in "姓（せい）", with: "たこ"
        fill_in "名（めい）", with: "大介"
        click_on '登録'
      end

      it 'イベント情報を作成し、一覧に表示すること' do
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_on '新規イベント作成'
        fill_in "タイトル", with: "不用品処理します"
        fill_in "内容", with: "扇風機処分します"
        click_on '登録する'
        expect(Event.count).to eq 1
        expect(page).to have_content '不用品処理します'
      end

      it 'イベントは編集・削除ができること' do
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_on '新規イベント作成'
        fill_in "タイトル", with: "不用品処理します"
        fill_in "内容", with: "扇風機処分します"
        click_on '登録する'
        click_link '不用品処理します'
        click_link '編集'
        fill_in "タイトル", with: "やっぱやめた"
        fill_in "内容", with: "無理でした"
        click_on '登録する'
        expect(page).to have_content 'やっぱやめた'
        click_link '削除する'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'やっぱやめた'
        expect(Event.count).to eq 0
      end

      it 'イベントは日付順でソートできること' do
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_on '新規イベント作成'
        fill_in "タイトル", with: "不用品処理します"
        fill_in "内容", with: "扇風機処分します"
        click_on '登録する'
        click_on '日付順ソート'
        list_0 = page.all(".media-body")[0]
        list_2 = page.all(".media-body")[2]
        expect(list_0).to have_content event1.title
        expect(list_2).to have_content event2.title
      end

      it 'イベントのタイトルをワード検索できること' do
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_on '新規イベント作成'
        fill_in "タイトル", with: "不用品処理します"
        fill_in "内容", with: "扇風機処分します"
        click_on '登録する'
        fill_in "タイトル検索", with: "不用品"
        click_on '検索する'
        list_0 = page.all(".media-body")[0]
        list_1 = page.all(".media-body")[1]
        expect(list_0).to have_content "不用品処理します"
        expect(list_1).not_to have_content event1.title
        expect(list_1).not_to have_content event2.title
      end

      it '自分のイベントのみソートできること' do
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_on '新規イベント作成'
        fill_in "タイトル", with: "不用品処理します"
        fill_in "内容", with: "扇風機処分します"
        click_on '登録する'
        click_on 'マイイベント'
        expect(page).to have_content "不用品処理します"
        expect(page).not_to have_content event1.title
        expect(page).not_to have_content event2.title
      end

      it 'イベントのカテゴリー検索できること' do
        label1 = FactoryBot.create(:label)
        label2 = FactoryBot.create(:label, title:"引っ越します！")
        label3 = FactoryBot.create(:label, title:"不用品処理")
        event1 = FactoryBot.create(:event, label_ids: [label1.id,label2.id])
        event2 = FactoryBot.create(:event, label_ids: [label2.id,label3.id])
        click_on 'トップページ'
        click_on 'イベント・不用品処理'

        select '引っ越してきました！', from: 'event_label_ids'
        click_on '検索する'
        expect(page).to have_content event1.title
        expect(page).not_to have_content event2.title
      end

      it 'イベントのユーザー検索できること' do
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        user1 = FactoryBot.create(:user)
        click_on 'ログアウト'
        fill_in "メールアドレス", with: user1.email
        fill_in "パスワード", with: user1.password
        click_on 'Log in'
        fill_in "姓（せい）", with: "いか"
        fill_in "名（めい）", with: "五右衛門"
        click_on '登録'
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_on '新規イベント作成'
        fill_in "タイトル", with: "不用品処理します"
        fill_in "内容", with: "扇風機処分します"
        click_on '登録する'
        click_on '選択して下さい'
        option=find("ul.dropdown-menu > li", text: "TEST_NAME2")
        option.click
        expect(page).to have_content event1.title
        expect(page).not_to have_content event2.title
        expect(page).not_to have_content "不用品処理します"
      end

      it '作成者以外は編集・削除ができないこと(ユーザー一覧へ飛ぶ)' do
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        user1 = FactoryBot.create(:user)
        click_on 'ログアウト'
        fill_in "メールアドレス", with: user1.email
        fill_in "パスワード", with: user1.password
        click_on 'Log in'
        fill_in "姓（せい）", with: "いか"
        fill_in "名（めい）", with: "五右衛門"
        click_on '登録'
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        visit edit_event_path(event1.id)
        expect(current_path).to eq root_path
      end

      it 'イベント詳細ページでコメント一覧が表示できること' do
        user = FactoryBot.create(:user)
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        comment1 = FactoryBot.create(:comment, user_id: user.id, event_id: event1.id)
        comment2 = FactoryBot.create(:comment, content: 'そうなの？', user_id: user.id, event_id: event1.id)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_link 'TEST_EVENT1'
        expect(page).to have_content "参加します！！"
        expect(page).to have_content "そうなの？"
      end

      it 'コメント数がイベント一覧画面に表示されること' do
        user = FactoryBot.create(:user)
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        comment1 = FactoryBot.create(:comment, user_id: user.id, event_id: event1.id)
        comment2 = FactoryBot.create(:comment, content: 'そうなの？', user_id: user.id, event_id: event1.id)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        list_0 = page.all(".media-body")[1]
        expect(list_0).to have_content 'コメント数2ケ'
      end

      it '新規イベントであれば、イベント一覧画面にNEWと表示されること' do
        user = FactoryBot.create(:user)
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        comment1 = FactoryBot.create(:comment, user_id: user.id, event_id: event1.id)
        comment2 = FactoryBot.create(:comment, content: 'そうなの？', user_id: user.id, event_id: event1.id)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        list_0 = page.all(".media-body")[0]
        list_1 = page.all(".media-body")[1]
        expect(list_0).to have_content 'NEW'
        expect(list_1).to have_content 'NEW'
      end

      it '既出イベントに未読コメントがあれば、イベント一覧画面に未読ありと表示されること' do
        user = FactoryBot.create(:user)
        event1 = FactoryBot.create(:event, start_date: Date.today - 1)
        event2 = FactoryBot.create(:event, start_date: Date.today + 1)
        comment1 = FactoryBot.create(:comment, user_id: user.id, event_id: event1.id)
        comment2 = FactoryBot.create(:comment, content: 'そうなの？', user_id: user.id, event_id: event1.id)
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_link 'TEST_EVENT1'
        fill_in "コメント欄", with: 'さくら散る'
        click_on 'コメントする'
        click_on 'ログアウト'

        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_on 'Log in'
        fill_in "姓（せい）", with: "いか"
        fill_in "名（めい）", with: "五右衛門"
        click_on '登録'
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        click_link 'TEST_EVENT1'
        fill_in "コメント欄", with: 'さくら泣く'
        click_on 'コメントする'
        click_on 'ログアウト'
        
        fill_in "メールアドレス", with: "TEST1@example.com"
        fill_in "パスワード", with: "123456"
        click_on 'Log in'
        click_on 'トップページ'
        click_on 'イベント・不用品処理'
        sleep 5
        list_0 = page.all(".media-body")[1]
        expect(list_0).to have_content '未読コメント有'
      end
    end
  end
end