require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:example) do
    @user = User.create(Name: 'Hammas', Photo: 'img.jpg', Bio: 'Developer', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now, Posts_Counter: 0)
    @user.confirm
    sign_in @user
    @post = Post.create(Title: 'Intro to JS', Text: 'Full Stack Development',
                        CommentsCounter: 0, LikesCounter: 0, user_id: @user.id)
    get user_posts_path(@user)
  end

  describe 'GET /index' do
    it 'renders http status' do
      expect(response).to have_http_status :ok
    end

    it "renders 'index' template" do
      expect(response).to render_template :index
    end

    it 'renders correct placeholder' do
      expect(response.body).to include @post.Title
    end
  end

  describe 'GET /show' do
    before(:example) { get user_post_path(@user, @post) }
    it 'renders http status' do
      expect(response).to have_http_status :ok
    end

    it "renders 'show' template" do
      expect(response).to render_template :show
    end

    it 'renders correct placeholder' do
      expect(response.body).to include @post.Text
    end
  end
end
