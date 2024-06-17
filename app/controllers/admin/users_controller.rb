class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :withdraw]



  def index
    @users = User.all
  end

  def show
    render partial: 'admin/users/detail', locals: { user: @user }
    unless @user
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
