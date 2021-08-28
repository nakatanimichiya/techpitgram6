class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :image, null: false
      # postテーブルに対して外部キーを設定
      t.references :post, foreign_key: true, null: false
      t.timestamps
    end
  end
end
