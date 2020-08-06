class Image < ApplicationRecord
  # carrierwaveでの記述
  mount_uploader :image, ImageUploader
  belongs_to :item
  validates :image, presence:true
end
