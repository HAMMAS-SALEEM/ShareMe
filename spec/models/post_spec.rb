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
      subject.Title = nil
      expect(subject).to_not be_valid
    end

    it 'should have title less than or equal to 250 characters' do
      name_length = subject.Title.length
      expect(name_length).to be <= 250
    end

    it 'should not have nil value for comments counter' do
      subject.CommentsCounter = nil
      expect(subject).to_not be_valid
    end

    it 'should have integer value greater or equal to 0 for comments counter' do
      subject.CommentsCounter = 0
      expect(subject).to be_valid
    end

    it 'should not have nil value for likes counter' do
      subject.LikesCounter = nil
      expect(subject).to_not be_valid
    end

    it 'should have integer value greater or equal to 0 for likes counter' do
      subject.LikesCounter = 0
      expect(subject).to be_valid
    end
  end

  context 'testing methods of post model' do
    it 'should return recent comments' do
      Comment.create(Text: 'Great Intro', user_id: user.id, post_id: subject.id)
      Comment.create(Text: 'It has everything', user_id: user.id, post_id: subject.id)
      Comment.create(Text: 'Do you have an academy?', user_id: user.id, post_id: subject.id)
      Comment.create(Text: "Who's your teacher", user_id: user.id, post_id: subject.id)
      Comment.create(Text: 'Would you like to give your facebook', user_id: user.id, post_id: subject.id)
      Comment.create(Text: 'Do you have these projects on github', user_id: user.id, post_id: subject.id)
      comments = subject.recent_comments
      expect(comments.length).to be 5
    end

    it 'should increment the Post counter in respectice user' do
      subject.update_posts_counter
      user_posts = subject.user.Posts_Counter
      expect(user_posts).to be 1
    end
  end
end
