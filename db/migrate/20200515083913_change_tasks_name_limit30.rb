class ChangeTasksNameLimit30 < ActiveRecord::Migration[5.2]
  def up
    # limitオプションで30文字以内に制限
    change_column :tasks, :name, :string, limit: 30
  end
  
  def down
    change_column :tasks, :name, :string
  end
end
