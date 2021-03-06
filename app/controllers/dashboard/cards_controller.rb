module Dashboard
  class CardsController < ApplicationController
    before_action :set_card, only: [:edit, :update, :destroy]

    def index
      @cards = current_user.cards
    end

    def new
      @card = current_user.cards.build
      @decks = current_user.decks
    end

    def edit
      @decks = current_user.decks
    end

    def create
      @card = current_user.cards.build(card_params)

      if @card.save
        redirect_to dashboard_cards_path, notice: t('.c_card')
      else
        render 'new'
      end
    end

    def update
      if @card.update(card_params)
        redirect_to dashboard_cards_path, notice: t('.u_card')
      else
        render 'edit'
      end
    end

    def destroy
      @card.destroy

      redirect_to dashboard_cards_path, notice: t('.d_card')
    end

    private

    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:deck_id, :original_text, :translated_text, :review_date, :review_stage, :image, :remote_image_url)
    end
  end
end
