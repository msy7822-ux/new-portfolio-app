class ApplicationController < ActionController::Base
    
    # sessions helperの読み込み
    protect_from_forgery with: :exception
    include SessionsHelper
    include UsersHelper
    
    def hello
       render html: 'Hello world' 
    end
    
    private
    
      # ログイン済みのユーザーかどうか確認
      def logged_in_user
        if logged_in? != true
          # store_location
          flash[:danger] = "ログインしてください"
          redirect_to login_url
        end
      end

end
