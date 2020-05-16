class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # NULL制約を設定
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
      # 一意制約を設定
      t.index :email, unique: true
    end
  end
end
