class FlashcardsController < ApplicationController
  def index
    @card = current_user.cards.with_ready_date.random.first if current_user
  end

  def compare
    check_card = CheckTranslation.call(params)
    redirect_to root_path, notice: check_card.notice
  end
end
