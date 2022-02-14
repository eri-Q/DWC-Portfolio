class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
end
