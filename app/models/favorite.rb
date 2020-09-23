class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
    # ここでuser_idとpost_idの組み合わせを一通りに絞る
    validates_uniqueness_of :post_id, scope: :user_id
end
