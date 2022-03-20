class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索機能のメソッド
  # if文で検索欄が空だった場合には、postの一覧が表示
  def self.search(search)
    if search == ''
      Post.includes(:user).order('created_at DESC')
    else
      Post.where(['title LIKE(?) OR body LIKE(?) OR user_id LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    end
  end

  # 各レコードとファイルを1対1の関係で紐づけるメソッド
  has_one_attached :image

  # 投稿する際のバリデーション設定
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :image, presence: true
  
  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
　  
　  # 古いタグを消す
    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(tag_name: old)
    end
　  
　  # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(tag_name: new)
      self.post_tags << new_post_tag
    end
  end
end
