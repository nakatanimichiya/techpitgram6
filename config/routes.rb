Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
  # パスワードを入力しなくてもプロフィールの情報を編集
  controllers: { registrations: 'registrations' }

  root 'posts#index'

  get '/users/:id', to: 'users#show', as: 'user'

  # postsコントローラーのnewアクション。投稿ページを表示するルーティング。
  # postsコントローラーのcreateアクション。投稿を作成するルーティング。
  # photosコントローラーのcreateアクション。投稿の写真を保存するルーティング。
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # post '/posts/:post_id/photos', to: 'photos#create', as: 'post_photos'

  # resourcesメソッドは以下の7つのアクションのルーティングを自動で生成します。
  resources :posts, only: %i(new create index show destroy) do
    resources :photos, only: %i(create)

#     likesコントローラーのcreateアクション。いいねの情報を保存するルーティング。
#     likesコントローラーのdestroyアクション。いいねの情報を削除するルーティング。
    resources :likes, only: %i(create destroy)

    # commentsコントローラーのcreateアクション。コメントの情報を保存するルーティング。
    # commentsコントローラーのdestroyアクション。コメントの情報を削除するルーティング。
    resources :comments, only: %i(create destroy)
  end
end
