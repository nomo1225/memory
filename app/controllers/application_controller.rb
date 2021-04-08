class ApplicationController < ActionController::Base
  include SessionsHelper #current_user logged_in?定義
  
  private
  
  def require_user_logged_in #loginユーザでない場合、ログイン画面へ
    unless logged_in?
      redirect_to login_url
    end
  end
end
