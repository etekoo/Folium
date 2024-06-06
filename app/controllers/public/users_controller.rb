class Public::UsersController < ApplicationController
  before_action :set_user, only: [:mypage, :edit, :update, :withdraw]
  before_action :authenticate_user!, except: [:show] # ログインしているかどうかを確認
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @plant_diaries = @user.plant_diaries
  end

  def edit
  end

  def show
    begin
      @user = User.find(params[:id])
      @plant_diaries = @user.plant_diaries
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = '指定されたユーザーが見つかりません。'
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報が更新されました。'
      redirect_to mypage_users_path
    else
      render :edit
    end
  end

  def unsubscribe
    # 退会処理など
  end

  def withdraw
    @user.update(is_active: false)
    reset_session
    flash[:notice] = '退会手続きが完了しました。ご利用ありがとうございました。'
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :password_confirmation)
  end
end