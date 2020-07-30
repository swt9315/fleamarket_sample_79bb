# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# 最終課題 DB設計

## Userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday_year|integer|null: false|
|birthday_month|integer|null: false|
|birthday_day|integer|null: false|
|user_image|string||
|introduction|text||

### Association

- has_many :products
- has_one :card
- has_one :address

## Cardテーブル

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|validated_code|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association

- belongs_to :user

## Addressテーブル

|Column|Type|Options|
|------|----|-------|
|post_code|integer|null: false|
|prefecture_id (active_hash)|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|string||
|user_id|references|null: false, foreign_key: true|

### Association

- belongs_to :user

## Productテーブル

以下のカラムはenumを使用
- condittion
- postage_user
- preparation

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|category_id|references|null: false, foreign_key: true|
|brand|string||
|condition|integer|null: false, default: 0|
|postage_user|integer|null: false, default: 0||
|prefecture_id (active_hash)|integer|null: false|
|preparation|integer|null: false, default: 0||
|price|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association

- has_many :images
- belongs_to :category
- belongs_to :user


## Imageテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|references|null: false, foreign_key: true|

### Association

- belongs_to :product

## Categoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|integer|null :false|

### Association

- has_many :products