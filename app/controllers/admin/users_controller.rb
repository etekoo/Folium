class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:mypage, :edit, :update, :withdraw]
  before_action :ensure_guest_user, only: [:edit]
  before_action :active_only, only: [:show]


  def index
    @users = User.where(is_active: true)
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

  def edit
  end

  def update
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
  
  #無効なユーザーを除外
  def active_only
    user = User.find(params[:id])
    if user.is_active?
    else
      flash[:alert] = "指定のユーザーは退会済みです"
      redirect_to mypage_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :password_confirmation)
  end

end
