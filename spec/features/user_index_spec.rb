require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @user = User.create(Name: 'Hammas', Photo: 'img.jpg', Bio: 'Developer', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now, Posts_Counter: 0)
    @user.confirm
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'shows the username' do
    expect(page).to have_content 'Hammas'
  end

  it 'shows the users profile picture when clicked' do
    expect(page).to have_css("img[src*='img.jpg']")
  end

  it 'shows Post Counter of user' do
    expect(page).to have_content('Number of Posts: 0')
  end

  it 'redirects to that users show page when a user clicked' do
    click_link('Hammas', match: :prefer_exact)
    expect(page).to have_content('Bio')
  end
end
