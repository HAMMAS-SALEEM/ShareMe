require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @user = User.create(Name: 'Hammas', Photo: 'img.jpg', Bio: 'Developer', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now)
    @post = Post.create(user: @user, Title: 'My title', Text: 'My text')
    @like = Like.create(user: @user, post_id: @post.id)
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'shows the username' do
    expect(page).to have_content 'Hammas'
  end

  it 'shows the users profile picture when clicked' do
    expect(page.find('img')['src']).to have_content 'img.jpg'
  end

  it 'redirects to that users show page when a user clicked' do
    click_link('Hammas', match: :prefer_exact)
    expect(page).to have_current_path(user_path(@user.id.to_s))
  end
end