class PostsController < ApplicationController
    before_action :logged_in_user, only: [:index, :show, :search, :create, :destroy, :edit, :update]
    
    def index
        @posts = Post.all
        # 今回はindexページから非同期で投稿を行うため空のモデルが必要
        @post = current_user.posts.build()
    end
    
    def create
        @post = current_user.posts.build(post_params)
        @posts = Post.all
        
        if @post.save
        #   flash[:success] = '投稿に成功しました'
            # 非同期通信で投稿する場合ここでreidirect_toメソッドを使ってはいけない
        end
    end 
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        flash[:success] = "投稿を削除しました"
        redirect_to user_url(@post.user)
    end
    
    def show
        @post = Post.find(params[:id])
        @user = @post.user
        @id = params[:id]
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update_attributes(post_params)
          # 更新に成功したときの処理
          flash[:success] = '投稿内容を更新しました'
          redirect_to post_url(@post)
        else
          render 'edit'
        end
    end
    
    
    private
    
    def post_params
       params.require(:post).permit(:circle_name, :univ_name, :content, :image) 
    end
end
