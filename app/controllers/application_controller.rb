class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  def not_authenticated
    redirect_to main_app.admin_login_path
  end
end
