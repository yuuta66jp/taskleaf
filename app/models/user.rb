class User < ApplicationRecord
  # has_secure_passwordメソッド(パスワードのハッシュ化や認証機能の追加)
  has_secure_password
end
