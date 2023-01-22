# ユニファ採用面接課題（写真管理アプリケーション（ツイート機能付き））

## ソフトウェアバージョン

* Ruby 3.1.3
* Ruby on Rails 7.0.4
* SQLite 3.40.1

## 開発環境の構築手順

### 前提

以下のOSで動作を確認しました

* macOS Ventura 13.0.1

## 動作確認方法

1. データベースを作成する

```
rails db:create
```

2. マイグレーションの実行

```
rails db:migrate
```

3. ユーザーデータの投入

```
rails c
以下は作成例です
User.create(name: "ユーザー", user_id: "A00001", password: "hogehoge", password_confirmation: "hogehoge")
```
4. 'http://localhost:3000'へアクセス

