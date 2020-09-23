class Post < ApplicationRecord
  belongs_to :user
  # Postのデフォルトの並び順を設定する
  default_scope -> { order( created_at: :desc ) }
  
  validates :user_id,     presence: true
  validates :content,     presence: true, length: { maximum: 144 }
  validates :circle_name, presence: true
  validates :univ_name,   presence:true
end
