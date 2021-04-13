class User < ApplicationRecord
  has_many :memories, dependent: :destroy
  has_many :photos, dependent: :destroy
  
  before_save { self.email.downcase! }
  
  validates :name1, presence: true, length: { maximum: 20 }
  validates :name1, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :status, presence: true, length: { maximum: 10 }
  mount_uploader :image, ImageUploader
  has_secure_password
end