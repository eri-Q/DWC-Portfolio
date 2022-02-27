require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    # test_postを作成し、空欄での登録ができるか確認します。
    subject { test_post.valid? }

    let(:user) { FactoryBot.create(:user) }
    let(:test_post) { post }
    let!(:post) { build(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        test_post.title = ''
        expect(subject).to eq false
      end

      it '100文字以下であること' do
        post.title = Faker::Lorem.characters(number: 100)
        expect(post.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
