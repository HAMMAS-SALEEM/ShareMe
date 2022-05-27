require 'rails_helper'

RSpec.describe 'Posts show page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Ani', photo: 'img.jpg', bio: 'Adviser', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now)
    @user1 = User.create(name: 'Vahan', photo: 'img.jpg', bio: 'Developer', email: 'test1@email.com',
                         password: 'password', confirmed_at: Time.now)
    @post = Post.create(author: @user, title: 'My title', text: 'My text')
    @comment = Comment.create(text: 'My first comment', author: @user, post_id: @post.id)
    @comment = Comment.create(text: 'My second comment', author: @user1, post_id: @post.id)
    @like = Like.create(author: @user, post_id: @post.id)
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit user_post_path(user_id: @post.author_id, id: @post.id)
  end

  describe 'Specs for view posts#show' do
    it 'Can see the posts title.' do
      expect(page).to have_content 'My title'
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
