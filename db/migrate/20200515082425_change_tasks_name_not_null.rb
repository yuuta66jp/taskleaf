class ChangeTasksNameNotNull < ActiveRecord::Migration[5.2]
  def change
    # NULL制約。引数にテーブル名、カラム名、null false or true
    change_column_null :tasks, :name, false
  end
end
