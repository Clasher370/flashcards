class FlashcardsController < ApplicationController
  def index
    set_card = SetCardOnIndex.call(user: current_user, session: session[:flashcards_card])
    @card = set_card.card
    @try = session[:flashcards_try]
  end

  def compare
    check_card = CheckTranslation.call(params)
    session[:flashcards_card] = check_card.card
    session[:flashcards_try] = check_card.session_try
    redirect_to root_path, notice: check_card.notice
  end
end
