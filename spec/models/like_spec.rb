require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0,
                        email: 'example@email.com', password: 'example', confirmed_at: Time.now)
    @user.confirm
    @post = Post.create(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0,
                        LikesCounter: 0, user_id: @user.id)
    @like = Like.new(user_id: @user.id, post_id: @post.id, post: @post)
    @like.save
  end
  context 'testing methods of model of like' do
    it 'should increment the likes counter in respective post' do
      @like.update_likes_counter
      post_likes = @post.LikesCounter
      expect(post_likes).to be 1
    end
  end
end
