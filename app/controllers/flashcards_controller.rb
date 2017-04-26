class FlashcardsController < ApplicationController
  def index
    random = SetRandomCard.call(user: current_user)
    @card = random.card
  end

  def compare
    check_card = CheckTranslation.call(params)
    redirect_to root_path, notice: check_card.notice
  end
end
