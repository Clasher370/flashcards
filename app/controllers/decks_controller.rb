class DecksController < ApplicationController
  def index
    @decks = current_user.decks.to_create_date
  end

  def new
    @deck = current_user.decks.build
  end

  def current_deck
    set_deck = SetCurrentDeck.call(params)
    redirect_to decks_path, notice: set_deck.notice
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to decks_path
    else
      render 'new'
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :id)
  end
end
