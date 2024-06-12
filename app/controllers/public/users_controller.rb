class Public::UsersController < ApplicationController
  before_action :set_user, only: [:mypage, :edit, :update, :withdraw]
  before_action :authenticate_user!, except: [:show] # ログインしているかどうかを確認
  before_action :ensure_current_user, only: [:edit, :update, :destroy]
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
      redirect_to mypage_users_path if current_user == @user
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
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
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

  def ensure_current_user
    begin
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to root_path, alert: '他のユーザーの編集画面にはアクセスできません。'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'ユーザーが見つかりません。'
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :password_confirmation)
  end
end