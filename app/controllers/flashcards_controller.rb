class FlashcardsController < ApplicationController
  def index
    @card = Card.with_ready_date.random_one
  end

  def compare
    check_card = CheckTranslation.call(params)
    redirect_to root_path, notice: check_card.notice
  end
end
