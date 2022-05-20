require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0)
  subject do
    Post.new(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0, LikesCounter: 0,
             user_id: user.id)
  end
  before { subject.save }
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

  context 'testing methods of user model' do
    it 'should return recent users' do
      # user = User.create(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0)
      # post = Post.create(Title: 'Intro to JS', Text: 'Full Stack Development', CommentsCounter: 0, LikesCounter: 0,
      #                    user_id: user.id)
      # users = users.recent_posts
      # expect(users.length).to be 1
    end
  end
end
