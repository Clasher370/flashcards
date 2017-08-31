# app/controllers/flashcards_controller.rb
class FlashcardsController < ApplicationController
  def index
    @card = SetCardOnIndex.call(user: current_user, session: session[:card]).card
  end

  def compare
    check_card = SuperMemo.new(params[:id], params[:user_text], params[:timer]).algorithm
    redirect_to root_path, notice: check_card
  end
end
