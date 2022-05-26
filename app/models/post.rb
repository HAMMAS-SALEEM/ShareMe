class Post < ApplicationRecord
  include ApplicationHelper

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :Title, presence: true, length: { maximum: 250 }
  validates :CommentsCounter, numericality: { greater_than_or_equal_to: 0 }
  validates :LikesCounter, numericality: { greater_than_or_equal_to: 0 }

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  def update_posts_counter
    user.increment!(:Posts_Counter)
  end
end
