class User < ApplicationRecord
  # has_secure_passwordメソッド(パスワードのハッシュ化や認証機能の追加)
  has_secure_password
  # バリデーションの設定
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
