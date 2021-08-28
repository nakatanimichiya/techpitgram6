class Post < ApplicationRecord

  belongs_to :user

  has_many :photos, dependent: :destroy

  # dependent: :destroyをつけることで、オブジェクトが削除されるときに、関連付けられたオブジェクトのdestroyメソッドが実行されます。つまり今回で言うと、投稿が削除されたら、その投稿に紐づくいいねも削除します。
  # orderメソッドは関連付けられたオブジェクトに与えられる順序を指定します
  # 新しいいいね順で取得したい場合。
  has_many :likes, ->{ order(created_at: :desc)}, dependent: :destroy

  # コメント機能
  # 投稿が削除されたら、その投稿に紐づくコメントも削除します。
  has_many :comments, dependent: :destroy

  # 親子関係のある関連モデル(今回でいうとPostモデルとPhotoモデル）で、親から子を作成したり保存するときに使えます
  # Postモデルの子に値するPhotoモデルを通して、photosテーブルに写真を保存
  accepts_nested_attributes_for :photos

  # index.html.erb
  def liked_by(user)
    # user_idとpost_idが一致するlikeを検索する
    Like.find_by(user_id: user.id, post_id: id)
  end
end
