class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # Postのデフォルトの並び順を設定する
  default_scope -> { order( created_at: :desc ) }
  
  mount_uploader :image, ImageUploader
  
  validates :user_id,     presence: true
  validates :content,     presence: true, length: { maximum: 144 }
  validates :circle_name, presence: true
  validates :univ_name,   presence:true
  
  private
  
  def image_size
    if image_size > 5.megabytes
      errors.add(:image, "サイズが5ギガバイトを超えています")
    end
  end
end
