class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def recent_users
    users = User.all
    users.each do |person|
      "Username is #{person}"
    end
  end
end
