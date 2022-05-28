require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:example) do
    @user = User.create(Name: 'Hammas', Photo: 'img.jpg', Bio: 'Developer', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now, Posts_Counter: 0)
    @user.confirm
    sign_in @user
    get users_path
  end
  describe 'GET /index' do
    it 'renders http status' do
      expect(response).to have_http_status(200)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should return correct placeholder' do
      expect(response.body).to include '<li class = "user_container">'
    end
  end

  describe 'GET /show' do
    before(:example) { get user_path(@user) }
    it 'renders http status' do
      expect(response).to have_http_status 200
    end

    it "renders 'show' template" do
      expect(response).to render_template :show
    end

    it 'should return correct placeholder' do
      expect(response.body).to include 'Bio'
    end
  end
end
