class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def not_authenticated
    redirect_to login_path, alert: 'Необходимо войти'
  end

  def set_locale
    locale = if current_user
               current_user.locale
             elsif params[:locale]
               session[:locale] = params[:locale]
             elsif session[:locale]
               session[:locale]
             else
               http_accept_language.compatible_language_from(I18n.available_locales)
             end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end
end
