class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = current_user.cards.build
    @decks = current_user.decks
  end

  def edit
    @decks = current_user.decks
    @stage = [*1..5]
  end

  def create
    @card = current_user.cards.build(card_params)

    if @card.save
      redirect_to cards_path, notice: 'Новая карта создана'
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path, notice: 'Карта изменена'
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy

    redirect_to cards_path, notice: 'Карта удалена'
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:deck_id, :original_text, :translated_text, :review_date, :review_stage, :image, :remote_image_url)
  end

  def require_deck
    if current_user.decks.empty?
      redirect_to new_deck_path, notice: 'Необходимо создать колоду'
    end
  end
end
