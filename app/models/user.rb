class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :birthday_year, presence: true, numericality: { only_integer: true } #presence 空かどうか, numericality 整数のみ許可、デフォルトで少数が可なのでonly_integer: trueで整数のみに設定
  validates :birthday_month, presence: true, numericality: { only_integer: true }
  validates :birthday_day, presence: true, numericality: { only_integer: true }
end
