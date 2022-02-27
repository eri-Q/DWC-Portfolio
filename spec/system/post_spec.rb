require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:post2) { create(:post, user: user2) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    visit posts_path(user, post)
  end

  describe '表示のテスト' do
    context '新規投稿画面' do
      before do
        visit new_post_path(user, post)
      end

      it 'bodyフォームが表示される' do
        expect(page).to have_field 'post[body]'
      end

      it '新規投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end
  end

  describe '編集のテスト' do
    context '自分の投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_post_path(post)
        expect(page).to have_current_path('/posts/' + post.id.to_s + '/edit', ignore_query: true)
      end
    end

    context '他人の投稿の編集画面への遷移' do
      it '遷移できない' do
        visit edit_post_path(user)
        expect(page).to have_current_path('/posts/' + user.id.to_s + '/edit', ignore_query: true)
      end
    end
  end
end
