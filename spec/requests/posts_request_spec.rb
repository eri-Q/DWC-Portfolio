require 'rails_helper'

RSpec.describe 'postコントローラーのテスト', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'ログイン済み' do
    before do
      sign_in user
    end

    context '投稿一覧ページが正しく表示される' do
      before do
        get posts_path
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end

      it '投稿一覧’ がレスポンスされること' do
        expect(response.body).to include('投稿一覧')
      end
    end
  end

  describe '非ログイン' do
    context '投稿一覧ページへ遷移されない' do
      before do
        get posts_path(user)
      end

      it 'レスポンスは 401 になる' do
        expect(response.status).to eq 401
      end
    end
  end

  # get admins_posts_path(admin)であればパスワードが違うため401エラーであり、
  # get admins_posts_pathであれば302のリダイレクトになるため、テストしたい方で記述してください。

  # describe '非ログイン' do
  #   context "投稿一覧ページへ遷移されない" do
  #     before do
  #       get admins_posts_path
  #     end
  #     it 'リクエストは302 OKとなること' do
  #       expect(response.status).to eq 302
  #     end
  #   end
  # end
end
