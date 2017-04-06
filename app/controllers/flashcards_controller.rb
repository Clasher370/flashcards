class FlashcardsController < ApplicationController

  def index
    @card = Card.with_ready_date.random_one
  end

  def compare
    flashcard = CheckTranslation.new(params[:original_text], params[:user_text])
    user_card = CardDateChanger.new(params[:id])

    if flashcard.compare
      user_card.change_date
      flash[:success] = "You gave the right answer"
      redirect_to root_path
    else
      flash[:danger] = "Your answer is #{params[:user_text]}, correct answer is #{params[:original_text]}"
      redirect_to root_path
    end
  end
end
