require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # FactoryBot.createで:userファクトリを指定しUserオブジェクトの作成
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # :taskファクトリを指定しTaskオブジェクトの作成
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        # visit [URL]で特定のURLにアクセスする
        visit login_path
        # <label>要素を指定し値を記述
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end
      it 'ユーザーAが作成したタスクが表示される' do
        # ページ内に特定の文字列が表示されていることを検証する
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end
