class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:top, :about] #ログイン認証が済んでいない状態でトップページ以外にアクセスしても、ログイン画面へリダイレクト

  before_action :configure_permitted_parameters, if: :devise_controller?

  #サインイン後の遷移先
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  #サインアウト後の遷移先
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
end
end
