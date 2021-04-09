class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorits_user, only: [:edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(15)
  end

  def show
    month_spend = (Date.today - @user.anniversary_day).to_i / 30
    @year_spend = month_spend / 12
    @month = month_spend - (@year_spend * 12)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = '登録しました。'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = '登録できませんでした。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = '情報を更新しました。'
      redirect_to root_path
    else
      flash.now[:danger] = '情報を更新できませんでした。'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'ユーザ情報は削除されました。'
    redirect_to root_url
  end
  
  #パスワードリマインダー　メール送信
  def forget
    @user = User.new
  end
  def forget_mail
    @user = User.find_by(email: params[:email])
    if @user
      @token = SecureRandom.hex(13) #ランダム文字列生成
      @user.assign_attributes(reset_token: @token) #userのreset_tokenに@token代入
      @user.save(validate: false) #パスワードのバリデーションがかからないよう指定
      ContactMailer.forget_pass(@user).deliver_now
      flash[:success] = 'パスワード再設定用メールを送信しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'このメールアドレスの登録はありません。'
      render :forget
    end
  end
  
  # パスワードリマインダー　リセットページ
  def reset_password
    if params[:reset_token] == nil || User.find_by(reset_token: params[:reset_token]) ==nil
      flash[:danger] = 'トークンが無効です。再度パスワード再設定メールを送信してください。'
      redirect_to login_path
    end
    @user = User.find_by(reset_token: params[:reset_token])
  end
  def run_reset
    @user = User.find(params[:user_id])
    unless @user
      flash[:danger] = '不正なアクセスです。' 
      redirect_to root_path
    else
      if @user.update(passwordreset_params)
        @user.assign_attributes(reset_token: nil) #トークンリセット
        @user.save(validate: false)
        flash[:success] = 'パスワードを再設定しました。'
        redirect_to login_path
      else
        flash.now[:danger] = 'パスワード再設定に失敗しました。'
        render :resetpass
      end
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name1, :name2, :status, :email, :password, :password_confirmation, 
                                 :image, :anniversary_day, :memories_place)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def authorits_user  #ユーザ認証
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def passwordreset_params  #パスワードリセット用
    params.permit(:password, :password_confirmation)
  end
  
end
