class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  mount_uploader :image, ImageUploader
  has_one_attached :image

  # foreigin_keyで参照先外部キーのカラムを指定
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # following_user:中間テーブルを通してfollowingモデルのフォローされる側を取得すること
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  # follower_user:中間テーブルを通してfollowerモデルのフォローする側を取得すること
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  # 設定した環境変数の呼び出し
  ENV['KEY']
  ENV['SECRET_KEY']
end
