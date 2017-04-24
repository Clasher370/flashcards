class FlashcardsController < ApplicationController
  def index
    @card = if current_user.decks.to_current.empty?
              current_user.cards.with_ready_date.random.first
            else
              current_user.decks.to_current.first.cards.with_ready_date.random.first
            end
  end

  def compare
    check_card = CheckTranslation.call(params)
    redirect_to root_path, notice: check_card.notice
  end
end
