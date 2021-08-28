class User < ApplicationRecord
  # dependent: :destroyをつけることで、オブジェクトが削除されるときに、関連付けられたオブジェクトのdestroyメソッドが実行されます
  # ユーザーが削除されたら、そのユーザーに紐づく投稿も削除します。
  has_many :posts, dependent: :destroy

  # いいね機能
  has_many :likes

  # コメント機能
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# 値がデータベースに保存される前に、そのデータが正しいかどうかを検証する仕組みをバリデーション
# validates :カラム名, バリデーション
# presence: trueは値が空ではないということ確かめるバリデーション
validates :name, presence: true, length: { maximum: 50 }

# パスワードを入力しなくてもプロフィールの情報を編集
def update_without_current_password(params, *options)

  if params[:password].blank? && params[:password_confirmation].blank?
    params.delete(:password)
    params.delete(:password_confirmation)
  end

  result = update_attributes(params, *options)
  clean_up_passwords
  result
end

end
