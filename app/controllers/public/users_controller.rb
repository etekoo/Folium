class Public::UsersController < ApplicationController
  before_action :set_user, only: [:mypage, :edit, :update]
  before_action :authenticate_user!, except: [:show] # ログインしているかどうかを確認

  def mypage
    @plant_diaries = @user.plant_diaries
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @plant_diaries = @user.plant_diaries
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
    @user.destroy
    flash[:notice] = '退会手続きが完了しました。ご利用ありがとうございました。'
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :password_confirmation)
  end
end