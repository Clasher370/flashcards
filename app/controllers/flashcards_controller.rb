class FlashcardsController < ApplicationController
  def index
    @card = if current_user.current_deck
              random_card(current_user.current_deck)
            else
              random_card(current_user)
            end
  end

  def compare
    check_card = CheckTranslation.call(params)
    redirect_to root_path, notice: check_card.notice
  end

  private

  def random_card(model)
    model.cards.with_ready_date.random.first
  end
end
