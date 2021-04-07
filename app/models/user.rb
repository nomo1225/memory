class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name1, presence: true, length: { maximum: 20 }
  validates :name1, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :status, presence: true, length: { maximum: 10 }
  has_secure_password
end