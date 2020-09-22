module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
        session[:user_id] = user.id
    end
    
    # ログイン中のユーザーをログアウトする
    def log_out
       session.delete(:user_id)
       @current_user = nil
    end
    
    # 現在ログイン中のユーザーを返す（いる場合）
    def current_user
       if session[:user_id]
          if @current_user.nil? 
              @current_user = User.find_by(id: session[:user_id])
              # ログインしていなければ、インスタンス変数に代入するだけなので返り値はnil
          else
              # 現在ログイン中のユーザーがすでに存在していた場合、そのユーザーのオブジェクトを返す
              @current_user
          end
       end
    end
    
    # ユーザーがログインしていればtrue、そうでなければfalseを返す
    def logged_in?
        !current_user.nil?
    end
    
    
    # ユーザーがアクセスしようとしたURLを記憶しておく
    def store_location
        if request.get? # GETリクエストのとき
            session[:forwarding_url] = request.original_url 
        end
    end
    
    # 記憶したURLまたはデフォルトページにリダイレクトする
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
end
