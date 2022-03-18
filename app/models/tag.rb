class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、post_tagsを通じて参照できる
  has_many :posts, through: :post_tags
  
  validates :name, uniqueness: true, presence: true
  
  # タグが存在していれば、タグの名前を配列として全て取得
  current_tags = self.tags.pluck(:name) unless self.tags.nill?
  # 現在取得したタグから送られてきたタグを除いてoldtagとする
  old_tags = current_tags - sent_tags
  # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
  new_tags = sent_tags - current_tags
  
  # 古いタグを消す
  old_tags.each do |old|
    self.tags.delete Tag.find_by(name: old)
  end
  
  # 新しいタグを保存
  new_tags.each do |new|
    new_post_tag = Tag.find_or_create_by(name: new)
    self.tags << new_post_tag
  end
end
