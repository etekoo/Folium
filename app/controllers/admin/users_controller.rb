class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :withdraw]



  def index
    @users = User.all
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

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'ユーザーのステータスを更新しました。'
    else
      flash[:alert] = 'ユーザーのステータスの更新に失敗しました。'
    end
    redirect_to admin_users_path
  end

  private

  def set_user
   @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :password_confirmation, :is_active)
  end
end
