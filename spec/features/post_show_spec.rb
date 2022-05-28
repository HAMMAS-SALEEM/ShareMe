require 'rails_helper'

RSpec.describe 'Posts show page', type: :feature do
  before(:each) do
    @user = User.create(Name: 'Ani', Photo: 'img.jpg', Bio: 'Adviser', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now, Posts_Counter: 0)
    @user.confirm
    @user1 = User.create(Name: 'Vahan', Photo: 'img.jpg', Bio: 'Developer', email: 'test1@email.com',
                         password: 'password', confirmed_at: Time.now, Posts_Counter: 0)
    @user1.confirm
    @post = Post.create(Title: 'My title', Text: 'My text', CommentsCounter: 0, LikesCounter: 0, user_id: @user.id)
    @comment = Comment.create(Text: 'My first comment', user_id: @user.id, post_id: @post.id)
    @comment.update_comments_counter
    @comment1 = Comment.create(Text: 'My second comment', user_id: @user1.id, post_id: @post.id)
    @comment1.update_comments_counter
    @like = Like.create(created_at: Time.now, updated_at: Time.now, user_id: @user.id, post_id: @post.id)
    @like.update_likes_counter
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit user_post_path(user_id: @user.id, id: @post.id)
  end

  describe 'Specs for view posts#show' do
    it 'Can see the posts title.' do
      expect(page).to have_content 'My text'
    end

    it 'shows the author of the post' do
      expect(page).to have_content 'Ani'
    end

    it 'shows the number of the comments of the post' do
      expect(page).to have_content 'Comments: 2'
    end

    it 'shows the number of the likes of the post' do
      expect(page).to have_content 'Likes: 1'
    end

    it 'shows the post content' do
      expect(page).to have_content 'My text'
    end

    it 'shows the username of a commentor' do
      expect(page).to have_content 'Ani'
      expect(page).to have_content 'Vahan'
    end

    it 'shows the comment of the commentor' do
      expect(page).to have_content 'My first comment'
      expect(page).to have_content 'My second comment'
    end
  end
end
