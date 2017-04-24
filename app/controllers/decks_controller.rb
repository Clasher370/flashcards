class DecksController < ApplicationController
  def index
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
