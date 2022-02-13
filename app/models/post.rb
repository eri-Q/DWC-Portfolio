class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  # 各レコードとファイルを1対1の関係で紐づけるメソッド
  has_one_attached :image
end
