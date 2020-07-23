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
- has_one :destination

## Cardテーブル

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|validated_code|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association

- belongs_to :user

## Destinationテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|adress|string|null: false|
|building_name|string||
|phone_number|integer||
|user_id|references|null: false, foreign_key: true|

### Association

- belongs_to :user

## Productテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|brand|string||
|condition|string|null: false|
|postage|string|null: false|
|prefecture|string|null: false|
|preparation|string|null: false|
|price|integer|null: false|

### Association

- has_many :images
- has_many :products_categoreis
- has_many :categories, through: :products_categories


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

### Association

- has_many :products_categoreis
- has_many :products, through: :products_categories

##  Products_categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|product_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|

### Association

- has_many :products_categories
- has_many :products, through: :products_categories