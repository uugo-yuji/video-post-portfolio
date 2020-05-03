class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_post, only: %i[show edit update destroy]

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @comment = Comment.new(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.new(post_params)
    if post.save
      flash[:notice] = "『#{post.title}』を作成しました"
      redirect_to post
    else
      redirect_to new_post_path, flash: {
        post: post,
        error_messages: post.errors.full_messages
      }
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
        redirect_to @post
    else
      flash[:post] = @post
      flash[:error_messages] = @post.errors.full_messages
      redirect_back(fallback_location: @post)
    end
  end

  def destroy
    @post.delete

    redirect_to posts_path, flash: { notice: "「#{@post.title}」が削除されました"}
  end

    private

      def post_params
        params.require(:post).permit(:title, :price, :content)
      end

      def set_target_post
        @post = Post.find(params[:id])
      end
end
