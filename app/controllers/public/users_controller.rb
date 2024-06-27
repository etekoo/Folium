class Public::UsersController < ApplicationController
  before_action :set_user, only: [:mypage, :edit, :update, :withdraw,]
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @plant_diaries = @user.plant_diaries
    @favorites = @user.favorites
    @communities = @user.communities
  end

  def edit
  end

  def show
    begin
      @user = User.find(params[:id])
      @plant_diaries = @user.plant_diaries
      @favorites = @user.favorites
      @communities = @user.communities
      @following_users = @user.following_user
      @follower_users = @user.follower_user
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

  # フォロー機能
  def follows
    @user = User.find(params[:id])
    @users = @user.following_user.page(params[:page]).per(3).reverse_order
    @following = @user.following_user

  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user.page(params[:page]).per(3).reverse_order
    @followers = @user.follower_user
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites # お気に入りの取得
  end

  def communities
    @user = current_user # ログインしているユーザーを取得するためのメソッド
    @communities = @user.communities
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