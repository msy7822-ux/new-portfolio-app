class UsersController < ApplicationController
  
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :univ_name, :password, :password_confirmation)
  end
end
