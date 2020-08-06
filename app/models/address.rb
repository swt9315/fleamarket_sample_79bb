class Address < ApplicationRecord
  validates :post_code, :prefecture_id, :city, :house_number, :phone_number ,presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :user, optional: true
    belongs_to_active_hash :prefecture
    validates :prefecture, presence: true
    validates :post_code, presence: true, format: { with: /\A\d{7}\z/ } #ハイフン無し、7桁
    validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ } #ハイフン無し、10or11桁
end
