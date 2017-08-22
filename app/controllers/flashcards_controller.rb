class FlashcardsController < ApplicationController
  def index
    set_card = SetCardOnIndex.call(user: current_user, session: session[:card])
    @card = set_card.card
    @try = session[:try]
  end

  def compare
    check_card = CheckTranslation.call(params)
    session[:card] = check_card.card
    session[:try] = check_card.session_try
    redirect_to root_path, notice: check_card.notice
  end
end
