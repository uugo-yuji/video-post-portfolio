require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    # 認証済みユーザとして
    context "as an authenticated user" do

      # テストユーザを作成,ログイン状態を作るため
      before do
        @user = FactoryBot.create(:user)
      end

      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :index
        expect(response.status).to eq(200)
      end

      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    # ログインしてないユーザとして
    context "as a not authorized user" do
      # 302レスポンスを返すことkoto
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      # サインイン画面にリダイレクトすること
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  # show
  describe "#show" do

    # ログインユーザとして
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response.status).to eq(200)
      end

      # sign_inにリダレクトすること
      it "redirects to the sign-in page" do
        get :show, params: { id: @post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  # create
  describe "#create" do
    # ログインユーザとして
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      # 投稿できること
      it "adds a post" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect {
          post :create, params: { post: post_params }
        }.to change(@user.posts, :count).by(1)
      end
    end

    # ログインしてないユーザとして
    context "as a not authorized user" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end

      # ログイン画面にリダイレクトすること
      it "redirects to the sign-in page" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end


  # update
  # ログインユーザとして
  context "as an authorized user" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
    end

    # 投稿を更新できること
    it "updates a post" do
      post_params = FactoryBot.attributes_for(:post, title: "Sample Post")
      sign_in @user
      patch :update, params: { id: @post.id, post: post_params }
      expect(@post.reload.title).to eq "Sample Post"
    end
  end
end