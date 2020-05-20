class HomeController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    @posts = params[:category_id].present? ? Category.find(params[:category_id]).posts : Post.all.order(created_at: :desc)
    @posts = @posts.page(params[:page])
    @categories = Category.all
    @bookmark = Bookmark.new
  end

  def show
  end
end
