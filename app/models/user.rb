class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true,
                   length: { minimum: 1, maximum: 24 } # nameの文字数は、1文字から24文字まで
  
  # 全角ひらがな
  # /\A[ぁ-んー－]+\z/

  has_many :item
  has_one :card
  has_one :destination
end
