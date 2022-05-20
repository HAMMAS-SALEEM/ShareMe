require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(Name: 'Peter', Photo: '123.jpg', Bio: 'Developer from US', Posts_Counter: 0) }
  before { subject.save }
  context 'testing validations of user model' do
    it 'should have a username' do
      subject.Name = nil
      expect(subject).to_not be_valid
    end

    it 'should have username less than or equal to 250 characters' do
      name_length = subject.Name.length
      expect(name_length).to be <= 250
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
