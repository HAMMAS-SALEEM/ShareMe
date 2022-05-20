class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  validates :Name, presence: true
  validates :Posts_Counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_users
    posts.limit(3).order(created_at: :desc)
  end
end
