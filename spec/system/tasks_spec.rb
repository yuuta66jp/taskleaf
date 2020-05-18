require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # letを使用し共通処理をまとめる。let(定義名)　{定義の内容}
  # FactoryBot.createで:userファクトリを指定しUserオブジェクトの作成
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    # visit [URL]で特定のURLにアクセスする
    visit login_path
    # context内に記述したletからlogin_userを取得
    # <label>要素を指定し値を記述
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  # shared_examplesで共通するitをまとめる
  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    # ページ内に特定の文字列が表示されていることを検証する
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      # it_behaves_likeメソッドで共通化したitを表示
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }
      it 'ユーザーAが作成したタスクが表示されない' do
        # ページ内に特定の文字列が表示されていないことを検証する(have_no_content)
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end
      # it_behaves_likeメソッドで共通化したitを表示
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        # have_selectorで特定の要素をCSSセレクタ(.alert-success)で指定する
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        # withinメソッドで探索する要素を特定のブロック内(error_explanationというidの要素内)に狭める事ができる
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end
