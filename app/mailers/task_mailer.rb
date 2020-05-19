class TaskMailer < ApplicationMailer
  # デフォルト値の設定
  default from: 'taskleaf@example.com'

  def creation_email(task)
    @task = task
    # mailメソッドでメールの情報を設定
    mail(
      subject: 'タスク作成完了メール',
      to: 'user@example.com',
    )
  end
end
