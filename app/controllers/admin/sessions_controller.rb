# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController



    GUEST_ADMIN_EMAIL = "admin@example.com"

  def guest_sign_in
    admin = Admin.find_or_create_by!(email: GUEST_ADMIN_EMAIL) do |admin|
      admin.password = SecureRandom.urlsafe_base64
      admin.name = "ゲスト管理者"
      # 他の必要な属性を設定
    end
    sign_in admin
    redirect_to admin_users_path, notice: 'ゲスト管理者としてログインしました。'
  end
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

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
