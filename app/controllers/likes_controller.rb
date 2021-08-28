class LikesController < ApplicationController

  # サインイン済みユーザーのみにアクセス許可
  before_action :authenticate_user!

  # likesコントローラーのcreateアクションを処理
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      # respond_toは返却するレスポンスのフォーマットを切り替えるためのメソッドです。
      # 今回いいねを押したら、リアルタイムでビューを反映させるためにフォーマットをJS形式でレスポンスを返す
      respond_to :js
    end
  end

  # likesコントローラーにdestroyアクション
  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  # permitで変更を加えられるキーを指定します。今回の場合、post_idキーを指定しています。
  # つまり、いいねを押したときに、どの投稿にいいねを押したのかpost_idの情報を変更できるように指定
  private
    def like_params
      params.permit(:post_id)
    end

end
