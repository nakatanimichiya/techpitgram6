class PostsController < ApplicationController

  # ユーザーがサインインしていない状態だと投稿ページで投稿しても、誰が投稿したか分からないです。また投稿された画像はサインインしたユーザーのみに見えるようにしたいですね。
  before_action :authenticate_user!

  # showアクションとdestroyアクションが呼ばれる前に@postを読み込むように書き換えます。
  before_action :set_post, only: %i(show destroy)

  # postsコントローラーのnewアクション。投稿ページを表示する
  def new
    @post = Post.new
    @post.photos.build
  end

  # postsコントローラーのcreateアクション。投稿を作成するルーティング。
  # photosコントローラーのcreateアクション。投稿の写真を保存するルーティング。
  # saveメソッドはオブジェクト（今回の場合@post）をデータベースに保存できます。redirect_toで指定したページに遷移させます。今回の場合、投稿が保存されても、されなくてもroot_pathにリダイレクトするように記述しています。
  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def index
#   limitメソッドは取り出すレコード数の上限を指定します
#   orderはデータベースから取り出すレコードを特定の順序で並べたい場合に使用します。
#   order('created_at DESC')とすることで、created_atの降順、つまり投稿された最新の日時z順に並び替え

#   関連するテーブルをまとめて取得するincludesメソッドを使うことでN+1問題を解決
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
  end

  # 投稿詳細ページ
  # find_byは与えられた条件にマッチするレコードのうち最初のレコードだけを返します
  # paramsとは送られてきたリクエスト情報をひとまとめにして、params[:パラメータ名]という形式で取得
  # { id: '1' }はparams[:id]で取得できるので、User.find_by(id: 1)となり、usersテーブルのidが1のレコードを取得
  def show
    # @post = Post.find_by(id: params[:id])　l7
  end

  # 削除機能
  def destroy
    # @post = Post.find_by(id: params[:id])　l7
    if @post.user == current_user
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end


  private
    def post_params
      # permitで変更を加えられるキーを指定します。今回の場合、captionキーとimageキーを指定しています。
      # mergeメソッドは2つのハッシュを統合するメソッドです。今回は誰が投稿したかという情報が必要なためuser_idの情報を統合しています。
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
