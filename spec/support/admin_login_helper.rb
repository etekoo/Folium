# spec/support/admin_login_helper.rb
module AdminLoginHelper
  def sign_in_as_admin
    email = ENV['ADMIN_EMAIL']
    password = ENV['ADMIN_PASSWORD']
    admin = Admin.create(email: email, password: password)
    sign_in admin
  end
end
