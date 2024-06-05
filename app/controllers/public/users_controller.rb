class Public::UsersController < ApplicationController
  def mypage
    @user = current_user
    @plant_diaries = @user.plant_diaries
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def update
     @user = current_user
  if @user.update(user_params)
    flash[:notice] = 'ユーザー情報が更新されました。'
    redirect_to mypage_users_path
  else
    render :edit
  end

  end

  def unsubscribe
  end

  def withdraw
    current_user.destroy
    flash[:notice] = '退会手続きが完了しました。ご利用ありがとうございました。'
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
