class BookmarksController < ApplicationController

  def create
    bookmark = current_user.bookmarks.build(post_id: params[:post_id])
    if bookmark.save!
      flash[:notice] = "ブックマークをしました"
      redirect_to posts_path
    else
      redirect_to posts_path, flash: {
        bookmark: bookmark,
        error_messages: bookmark.errors.full_messages
      }
    end
  end

  def destroy
    bookmark = Bookmark.find_by(post_id: params[:post_id], user_id: current_user.id)
    bookmark.destroy
    redirect_to posts_path, flash: { notice: "ブックマークが解除されました"}
  end
end
