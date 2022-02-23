class CommentsController < ApplicationController
  def create
    # postを1つ見つけてコメントを作成し、コメントを保存したらその投稿詳細ページに戻る
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
    @comment.post_id = @post.id
    @comment.save
  end

  def destroy
    # commentをidやpost_idから見つけて削除し、その投稿詳細ページに戻る
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
