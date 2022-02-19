class CommentsController < ApplicationController
  def create
    # postを1つ見つけてコメントを作成し、コメントを保存したらその投稿詳細ページに戻る
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
  end

  # def edit
  #   @comment = Comment.find(params[:post_id])
  # end

  # def updated
  #   byebug
  #   comment = current_user.comments.find(params[:post_id])
  #   comment.update(comment_params)
  #   redirect_to post_path(post.id)
  # end

  def destroy
    # commentをidやpost_idから見つけて削除し、その投稿詳細ページに戻る
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
