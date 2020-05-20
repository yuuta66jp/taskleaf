class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  # 検証用メソッドの作成
  validate :validate_name_not_including_comma

  # アソシエーションの設定
  belongs_to :user
  # has_one_attachedメソッドで1対1で画像を紐付ける
  has_one_attached :image

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

  # csvファイルの出力メソッド
  # どの属性をどの順番で出力するかを定義
  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    # CSV.generateを使いCSVデータの文字列を作成
    CSV.generate(headers: true) do |csv|
      # CSVの1行目としてヘッダを出力(属性名をそのまま使う)
      csv << csv_attributes
      # allメソッドで全件取得し1レコード毎に1行を出力
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    # CSV.foreachでCSVファイルを一行ずつ読み込む
    # headers: trueで1行目をヘッダとする
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      # to_hashメソッドでハッシュに変換
      # sliceメソッドでcsv_attributesメソッドの戻り値の配列内の要素だけを取り出す("name", "description"など)
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  
  private

  def validate_name_not_including_comma
    # 後置ifで検証(ぼっち演算子でnilを許可)
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
