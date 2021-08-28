class RegistrationsController < Devise::RegistrationsController

  protected

  # パスワードを入力しなくてもプロフィールの情報を編集
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
  # プロフィール編集後はログインしているユーザーのプロフィールページにリダイレクトするように実装
  def after_update_path_for(resource)
    user_path(resource)
  end
end
