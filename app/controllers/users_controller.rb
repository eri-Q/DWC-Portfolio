class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(3).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end
  
  def edit
  @user = User.find(params[:id])
  end
  
  def update
  user = User.find(params[:id])
  user.update(user_params)
  redirect_to user_path(user.id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_name, :email, :image, :telephone_number)
  end
end
