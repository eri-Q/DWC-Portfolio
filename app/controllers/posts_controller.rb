class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.page(params[:page]).per(9).reverse_order
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(6).reverse_order
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search]).reverse_order
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
end
