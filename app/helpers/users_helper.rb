module UsersHelper
    # ユーザーの投稿の活動内容は最初の１０文字しか表示しないメソッド
    def num_of_words(text)
        arr = text.split("")
        result_text = []
        if arr.size > 10
            10.times{|n|
                result_text << arr[n]
            }
            return result_text.join("")
        else
            return text
        end
    end
end
