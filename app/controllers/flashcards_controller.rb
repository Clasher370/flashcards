class FlashcardsController < ApplicationController
  def index
    @card = Card.with_ready_date.random_one
  end

  def compare
    check_card = CardChecker.call(params)

    if check_card.success?
      flash[:success] = "You gave correct answer!"
      redirect_to root_path
    else
      flash[:danger] = "Your answer is #{params[:user_text]}, correct answer is #{params[:original_text]}"
      redirect_to root_path
    end
  end
end
