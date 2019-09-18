# README

- バージョン情報
```
  ruby '2.6.3'
  rails '5.2.3'
```
- カタログ設計

```
アプリ名：Share House MGR
使用対象者：シェアハウスの居住者と管理者
概要：共同生活のタスク管理、住居人同士の情報共有、住居人と管理者の情報共有
```
</font>

- 機能一覧
> 共用タスク（ゴミ出し、トイレ掃除）の管理、受け渡し。
>
> 住居者の情報管理（管理ページ）
>
> 住居者間で情報交換（イベント、不用品処理などの告知）
>
> 住居者同士でのチャット機能　(住居者と管理者間もあり)
>
> クレームや意見、もしくは有益な情報を出し合う掲示板機能
>
> 家賃の支払状況を管理
- テーブル定義書
```
https://docs.google.com/spreadsheets/d/1Z0g9SOsKzN-r_mBpIHOfev7w4_VR5sGU/edit#gid=212823087
```
- ER図 / 画面遷移図 / ワイヤーフレーム
```
https://cacoo.com/diagrams/jEdhpG7IXykGASNR/064D2

もしくはローカル環境にて、下記ファイルを"Alt + D" でプレビューを表示する
./public/my_app_er.pu

```

- 使用予定Gem
```
ログイン管理機能
- device
- cancancan
- rails_admin

OAuth機能
- omniauth
- omniauth-google-oauth2

Password管理
- bcrypt

ページネーション
- kaminari

カレンダー機能
- simple_calendar

ラベル分析
- chartkick

検索機能
- ransak

