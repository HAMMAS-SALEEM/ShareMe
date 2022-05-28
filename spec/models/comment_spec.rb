require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0,
                        email: 'example@email.com', password: 'example', confirmed_at: Time.now)
    @user.confirm
    @post = Post.create(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0,
                        LikesCounter: 0, user_id: @user.id)
    @comment = Comment.new(post: @post, Text: 'Good tutorial', user_id: @user.id, post_id: @post.id)
    @comment.save
  end
  context 'testing methods of model of comment' do
    it 'should increment the comments counter in respective post' do
      @comment.update_comments_counter
      post_comments = @comment.post.CommentsCounter
      expect(post_comments).to be 1
    end
  end
end
