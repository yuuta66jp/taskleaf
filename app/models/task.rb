class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  # 検証用メソッドの作成
  validate :validate_name_not_including_comma

  # アソシエーションの設定
  belongs_to :user

  # scopeメソッドを使用しクエリー用メソッド(絞り込み条件)をカスタムメソッド(recent)として定義する
  scope :recent, -> { order(created_at: :desc) }
  
  private

  def validate_name_not_including_comma
    # 後置ifで検証(ぼっち演算子でnilを許可)
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
