class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # 動作確認のためSidekiqのログにメッセージを表示する
    Sidekiq::Logging.logger.info "サンプルジョブを実行しました"
  end
end
