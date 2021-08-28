class ApplicationController < ActionController::Base
  # nameカラムを保存できるようにストロングパラメーターを追記
  protect_from_forgery with: :exception

#   Applicationコントローラーは全てのコントローラーが読まれる前に必ず読まれるコントローラーです。例えばpagesコントローラーのhomeアクションが読まれる前にApplicationコントローラーが読まれます。

# ただ、nameカラムを保存できるようにする記述はサインアップやアカウントをアップデートするときだけにしか必要がありません。

# なので、before_action :configure_permitted_parameters, if: :devise_controller?と記載することで、configure_permitted_parametersというメソッドは、devise_controllerを使うときしか処理しないということをApplicationコントローラーを読み込む前に判断します。
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end
