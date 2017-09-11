module Dashboard
  class DecksController < ApplicationController
    def index
      @decks = current_user.decks.by_create_date
    end

    def new
      @deck = current_user.decks.build
    end

    def create
      @deck = current_user.decks.build(deck_params)
      if @deck.save
        redirect_to dashboard_decks_path, notice: t('.c_deck')
      else
        render 'new'
      end
    end

    private

    def deck_params
      params.require(:deck).permit(:name, :id)
    end
  end
end
