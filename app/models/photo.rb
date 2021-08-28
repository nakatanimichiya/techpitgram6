class Photo < ApplicationRecord

  belongs_to :post

  # 写真は必ずアップロードしていない場合は投稿できないようにします。
  validates :image, presence: true

  # Photoモデルのimageカラムと、先ほど作成したアップローダーImageUploaderと紐付けを
  mount_uploader :image, ImageUploader
end

