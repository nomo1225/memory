class Memory < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :date, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
