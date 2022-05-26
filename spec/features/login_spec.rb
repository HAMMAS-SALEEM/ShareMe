require 'rails_helper'

RSpec.describe 'login page', type: :feature do
  before(:each) do
    User.create(Name: 'example', Posts_Counter: 0, email: 'example@email.com', password: 'hammas')
    visit user_session_path
  end
  context 'should render login page elements' do
    it 'should render email field' do
      expect(page).to have_field(type: 'email')
    end
    it 'should render email field' do
      expect(page).to have_field(type: 'password')
    end
    it 'should render email field' do
      expect(page).to have_button(type: 'submit')
    end
  end

  context 'testing log in' do
    it 'should return error on logging in with empty fields' do
      visit new_user_session_path
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    it 'should return error on logging in with wrong entries' do
      visit new_user_session_path
      fill_in 'Email', with: 'example@email.com'
      fill_in 'Password', with: 'hamm'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'should redirect to users page after logging in with right entries' do
      visit new_user_session_path
      fill_in 'Email', with: 'example@email.com'
      fill_in 'Password', with: 'hammas'
      click_button 'Log in'
      expect(page).to have_content 'You have to confirm your email address before continuing.'
    end
  end
end
