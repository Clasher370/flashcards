# app/controllers/flashcards_controller.rb
class FlashcardsController < ApplicationController
  before_action :set_card, only: [:index, :compare]

  def compare
    flash.now[:notice] = SuperMemo.new(params[:id], params[:user_text], params[:timer]).algorithm
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def set_card
    @card = SetCardOnIndex.call(user: current_user).card
  end
end
