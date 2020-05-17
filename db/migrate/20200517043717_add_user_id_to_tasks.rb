class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    # executeでSQL文を実行(DELETE FROM tasks;で作成したタスクを全て削除)
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
