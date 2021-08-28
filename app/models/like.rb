class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 投稿①に対して、Aさんがいいねを押せる回数は1回にします。
  # uniquenessは、オブジェクトが保存される直前に、属性の値が一意（unique）であり重複していないこと
  # user_idとpost_idの組み合わせが重複していないこと
  validates :user_id, uniqueness: { scope: :post_id }

end
