class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @favorites = current_user.favorites.create(post_id: params[:post_id])
        # いいねを押した時に前の画面に戻る
        redirect_back(fallback_location: root_path)
    end 
    
    def destroy
        @post = Post.find(params[:post_id])
        @favorite = current_user.favorites.find_by(post_id: @post.id)
        @favorite.destroy
        redirect_back(fallback_location: root_path)
    end 
end
