class Photo < ApplicationRecord
  belongs_to :memory
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
end
