class UsersController < ApplicationController
  # ログインしていないユーザーがアクセスできないアクション
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # アカウントが異なるユーザーがアクセスできないアクション（ログインは完了済み）
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @users = User.all
  end 
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      # 保存が成功したときの処理
      log_in(@user)  # ユーザー登録後にログインする
      flash[:success] = 'Welcome to Circlindex Web site'
      redirect_to user_url(@user)
    else
      render 'users/new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit 
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功したときの処理
      flash[:success] = 'プロフィールを更新しました'
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end
  
  # ユーザー情報を削除するアクション
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :univ_name, :password, :password_confirmation, :picture)
  end
  
  
  # ログイン済みのユーザーかどうか確認
  def logged_in_user
    if logged_in? != true
      # store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = "あなたのアカウントではありません"
      redirect_to root_url
    end 
  end
end
