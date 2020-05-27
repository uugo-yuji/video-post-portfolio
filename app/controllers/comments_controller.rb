class CommentsController < ApplicationController

  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.post
    else
      flash[:comment] = comment
      flash[:error_messages] = comment.errors.full_messages
      redirect_back(fallback_location: comment.post)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.post, flash: { notice: 'コメントが削除されました'}
  end

    private
      def comment_params
        params.require(:comment).permit(:post_id, :comment)
      end
end
