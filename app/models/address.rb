class Address < ApplicationRecord
  validates :post_code, :prefecture_id, :city, :house_number, :phone_number ,presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :user, optional: true
    belongs_to_active_hash :prefecture
    validates :prefecture, presence: true
end
