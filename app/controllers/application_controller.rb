class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :set_locale

  private

  def not_authenticated
    redirect_to login_path, alert: 'Необходимо войти'
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
