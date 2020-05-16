class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    # boolean型,NULL制約,デフォルト値を設定
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
