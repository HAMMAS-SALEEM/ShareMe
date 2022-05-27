require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0,
                        email: 'example@email.com', password: 'example', confirmed_at: Time.now)
    @user.confirm
    @post = Post.create(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0,
                        LikesCounter: 0, user_id: @user.id)
    @like = Like.new(user_id: @user.id, post_id: @post.id, post: @post)
    @like.save
  end
  context 'testing validations of post model' do
    it 'should have a title' do
      @post.Title = nil
      expect(@post).to_not be_valid
    end

    it 'should have title less than or equal to 250 characters' do
      name_length = @post.Title.length
      expect(name_length).to be <= 250
    end

    it 'should not have nil value for comments counter' do
      @post.CommentsCounter = nil
      expect(@post).to_not be_valid
    end

    it 'should have integer value greater or equal to 0 for comments counter' do
      @post.CommentsCounter = 0
      expect(@post.CommentsCounter).to be_kind_of Numeric
    end

    it 'should not have nil value for likes counter' do
      @post.LikesCounter = nil
      expect(@post).to_not be_valid
    end

    it 'should have integer value greater or equal to 0 for likes counter' do
      @post.LikesCounter = 0
      expect(@post.CommentsCounter).to be_kind_of Numeric
    end
  end

  context 'testing methods of post model' do
    it 'should return recent comments' do
      comments = @post.recent_comments
      expect(comments.length).to be 0
    end

    it 'should increment the Post counter in respectice user' do
      @post.user = @user
      @post.update_posts_counter
      user_posts = @user.Posts_Counter
      expect(user_posts).to be 1
    end
  end
end
