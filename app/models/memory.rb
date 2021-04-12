class Memory < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :date, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
