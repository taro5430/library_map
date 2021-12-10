<div align="right">
  <img src='https://img.shields.io/badge/build-passing-brightgreen'>
  <img src='https://img.shields.io/badge/deploy-passing-brightgreen'>
</div>

# Library map for study  

## 概要
「Library map for study」は勉強を目的とした方のための図書館まとめアプリです。
アプリに登録されている図書館は基礎データとして、図書館の写真・位置情報や勉強するスペース・コンセントの有無などを持っており、このアプリを使えば勉強に適した図書館を確認できるようになっています。図書館の登録は各ユーザーによって行われ、いいねやコメント機能により、登録されている図書館のリアルな声も聞くことができます。

## なぜ作ったのか  
  私は勉強する時は図書館などの誘惑のない静かな環境の方が集中できるのですが、図書館によって勉強できる場所とできない場所があります。そこで事前に勉強できるかどうか把握できるサービスが欲しいと思い作成しました。また、私が勉強できる図書館に行くと、いつも多くの人が勉強していますし、何人かの友人に意見を聞いてみても、全員から好意的な反応をいただいたので、需要も大きいのではないかと思い、作成することに決めました。

## こだわりポイント
*  図書館を登録する際、基本データとして勉強スペースやコンセントの有無を必須とすることで、勉強できるかどうか可視化 できるようにしました。また、Google Maps APIを使用することで、地図上からも図書館を探せるようにしました。  
*  AWSの勉強のため、EC2・S3・RDS・Route53を利用して本番環境を構築しました。  
*  circleciによる自動テスト自動デプロイを実装しました。

## 機能一覧
* 図書館の検索、登録
* 図書館に対するいいねやコメント機能
* 自分が登録した図書館がいいね、コメントされた場合の通知機能
* ゲストログイン機能
* 管理者権限（管理者は登録されている図書館を自由に削除、編集できます。）

## 使い方
* ### 登録されている図書館の見方
  図書館の探し方は主に下記の２通りあります。どちらもログインしなくても操作可能です。  
  1. Mapから探す。  
  トップページにあるMapから図書館をクリックして詳細を見ることができます。

      <img src='https://user-images.githubusercontent.com/83792679/145384261-f87e12ba-d864-4cf3-81c7-835bccebd9b9.gif' width='90%'>

  1. 図書館一覧画面から探す。  
  「図書館一覧」をクリックすると登録されている図書館が一覧で表示されます。  
  一覧から見たい図書館をクリックして詳細を確認できます。また、キーワード検索も可能です。  

      <img src='https://user-images.githubusercontent.com/83792679/145384354-ca4d71bf-0ddc-485d-8a62-49d520eb97d2.gif' width='90%'>
  
* ### 図書館の登録方法
  「図書館登録」をクリックして図書館の登録ができます。（新規登録してログインするか、ゲストユーザーとしてログインが必要です。）         
  下記のデモはゲストユーザーとしてログインしています。

  <img src='https://user-images.githubusercontent.com/83792679/145384418-53469085-965e-4676-944f-7e2bf39034d2.gif' width='90%'>

* ### いいね、コメントの方法
  登録されている図書館の詳細画面でいいねやコメントができます。また、自分がしたいいねやコメントはプロフィール画面で確認できます。（新規登録してログインするか、ゲストユーザーとしてログインが必要です。）  
  下記のデモはゲストユーザーとしてログインしています。  

  <img src='https://user-images.githubusercontent.com/83792679/145384465-2843a502-eedc-401b-819f-a44f8a2820ba.gif' width='90%'>

## ER図
![er](https://user-images.githubusercontent.com/83792679/145403957-0988d1d7-8408-471e-8ff5-bfb5c1ab8ea7.png)


## 環境
* ホストOS  
  <img src='https://img.shields.io/badge/-Mac-black?'>

* 言語  
  <span class='d-flex'>
    <img src='https://img.shields.io/badge/-HTML5-E34F26?logo=HTML5&logoColor=white'>
    <img src='https://img.shields.io/badge/-CSS3-1572B6?logo=CSS3'>
    <img src='https://img.shields.io/badge/-Javascript-black?logo=Javascript'>
    <img src='https://img.shields.io/badge/-Ruby-CC342D?logo=ruby'>
  </span>

* フレームワーク  
  <img src='https://img.shields.io/badge/-Ruby on rails-CC0000?logo=ruby'>

* CSSフレームワーク  
  <img src='https://img.shields.io/badge/-Bootstrap-563D7C?logo=Bootstrap&logoColor=white'>  

* JSライブラリ  
  <img src='https://img.shields.io/badge/-jQuery-0769AD?logo=jQuery'>  

* データベース  
  <img src='https://img.shields.io/badge/-MySQL-4479A1?logo=MySQL&logoColor=white'>  

* インフラ  
  <span class='d-flex'>
    <img src='https://img.shields.io/badge/-Docker-2496ED?logo=Docker&logoColor=white'>
    <img src='https://img.shields.io/badge/-Amazon AWS-232F3E?logo=Amazon AWS'>
    <img src='https://img.shields.io/badge/-EC2-orange?logo=Amazon AWS'>
    <img src='https://img.shields.io/badge/-S3-569A31?logo=Amazon S3&logoColor=white'>
    <img src='https://img.shields.io/badge/-RDS-563D7C?logo=Amazon AWS'>
    <img src='https://img.shields.io/badge/-Route 53-563D7C?logo=Amazon AWS'>
  </span>

* テストフレームワーク  
  <img src='https://img.shields.io/badge/-RSpec-black?'>  

* その他ツールなど  
  <span class='d-flex'>
    <img src='https://img.shields.io/badge/-Git-black?&textColor=orange'>
    <img src='https://img.shields.io/badge/-GitHub-181717?logo=GitHub'>
    <img src='https://img.shields.io/badge/-RuboCop-black?'>
    <img src='https://img.shields.io/badge/-CirclCI-343434?logo=CircleCI'>
  </span>

## アプリの起動方法
開発環境でのアプリの起動方法は下記の通りです。  
homebrewのインストール
```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Dockerのインストール
```
  brew update
  brew install caskroom/cask/brew-cask
  brew cask install docker
```

Dockerスタート
```
  open /Applications/Docker.app
```
プロジェクトのクローン
```
  git clone https://github.com/taro5430/library_map.git
  cd library_map
```
アプリのセットアップ
```
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml build
  docker network create library_map-network
  docker-compose run app rails assets:precompile RAILS_ENV=development
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
  docker-compose exec app rails active_storage:install db:migrate RAILS_ENV=development
```
ページを開く
```
  http://localhost:3000
```
アプリの終了
```
  docker-compose stop
```
