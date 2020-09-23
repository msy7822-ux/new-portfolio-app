class User < ApplicationRecord
    # postモデルとの紐付け(一つのユーザーに対して複数のpostが生成されることが想定される)
    # ユーザーが削除されたときにそのユーザーに紐づいた投稿を全て削除する
    has_many :posts, dependent: :destroy
    
    before_save { self.email = self.email.downcase }
    
    # 画像のアップローダー
    mount_uploader :picture, PictureUploader
    
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :univ_name, presence: true
    
    # 画像のリサイズを行う
    validate :picture_size
    
    # セキュアなパスワードの実装
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    
    private
    
    def picture_size
        if picture.size > 5.megabytes
           errors.add(:picture, 'サイズが５メガバイトを超えています') 
        end
    end
    
end