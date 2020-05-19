class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  # 検証用メソッドの作成
  validate :validate_name_not_including_comma

  # アソシエーションの設定
  belongs_to :user

  # scopeメソッドを使用しクエリー用メソッド(絞り込み条件)をカスタムメソッド(recent)として定義する
  scope :recent, -> { order(created_at: :desc) }

  # 検索対象となるカラムを指定する(デフォルトでは全てのカラム)
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end
  # 検索対象とする関連テーブルを指定できる(空の配列を返し意図しない関連を含めない)
  def self.ransackable_associations(auth_object = nil)
    []
  end

  
  private

  def validate_name_not_including_comma
    # 後置ifで検証(ぼっち演算子でnilを許可)
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
