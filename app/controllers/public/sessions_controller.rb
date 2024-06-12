# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  GUEST_USER_EMAIL = "guest@example.com"
  
  def guest_sign_in
    user = User.find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      # 他の必要な属性を設定
    end
    sign_in user
    redirect_to mypage_users_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    mypage_users_path
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
