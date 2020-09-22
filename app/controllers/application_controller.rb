class ApplicationController < ActionController::Base
    
    # sessions helperの読み込み
    protect_from_forgery with: :exception
    include SessionsHelper
    
    def hello
       render html: 'Hello world' 
    end
end
