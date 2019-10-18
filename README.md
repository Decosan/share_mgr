# README

- バージョン情報
```
  ruby '2.6.3'
  rails '5.2.3'
```
- カタログ設計

```
アプリ名：
Share House MGR

使用対象者：
シェアハウスの居住者と管理者

概要：
共同タスク管理
家賃支払い情報の管理
住居人同士の情報共有
住居人と管理者の情報共有
```
</font>

- 機能一覧
> 共用タスク
> （ゴミ出し、トイレ掃除の管理、受け渡し、評価）
>
> 住居者間で情報共有と情報交換（各種イベント、不用品処理の告知など）
>
> 住居者同士、または管理者とのチャット機能
>
> 意見や有益な情報を出し合う掲示板機能
>
> 家賃の支払状況を管理（支払い後に管理者へメール通知し、管理者は入金確認して返信メールを返す）
>
> クレジットカードにて家賃の支払い


- テーブル定義書
```
https://docs.google.com/spreadsheets/d/1Z0g9SOsKzN-r_mBpIHOfev7w4_VR5sGU/edit#gid=1333122057
```

- ER図 / 画面遷移図 / ワイヤーフレーム
```
https://cacoo.com/diagrams/jEdhpG7IXykGASNR/064D2

もしくはローカル環境にて、下記ファイルを"Alt + D" でプレビュー表示可能
./public/my_app_er.pu

```

- 使用予定Gem
```
ログイン管理機能
- device
- cancancan
- rails_admin

クレジットカード決済機能
- payjp

ページネーション
- kaminari

カレンダー機能
- simple_calendar


