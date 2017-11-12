class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  
  mount_uploader :picture, PictureUploader
    validates :picture,
      presence: true, on: :create, # create時のみ必須
      file_size: {
        maximum: 10.megabytes.to_i # 最大10MBに制限
        # maximum: 500.kilobytes.to_i # 最大500KBに制限
      }
    
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end