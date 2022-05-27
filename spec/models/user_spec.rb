require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0,
                        email: 'example@email.com', password: 'example', confirmed_at: Time.now)
    @user.confirm
    @post = Post.create(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0,
                        LikesCounter: 0, user_id: @user.id)
    @like = Like.new(user_id: @user.id, post_id: @post.id, post: @post)
    @like.save
  end
  context 'testing validations of user model' do
    it 'should have a username' do
      @user.Name = nil
      expect(subject).to_not be_valid
    end

    it 'should have username less than or equal to 250 characters' do
      name_length = @user.Name.length
      expect(name_length).to be <= 250
    end
  end

  context 'testing methods of user model' do
    it 'should return recent users' do
      Post.create(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0, LikesCounter: 0,
                  user_id: @user.id)
      user_posts = @user.recent_posts
      expect(user_posts.length).to be 2
    end
  end
end
