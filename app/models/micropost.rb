class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :asc) }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end