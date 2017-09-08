# app/controllers/flashcards_controller.rb
class FlashcardsController < ApplicationController
  before_action :set_card, only: :index

  def compare
    notice = SuperMemo.new(params[:id], params[:user_text], params[:timer]).algorithm
    set_card
    respond_to do |format|
      format.html { redirect_to root_path, notice: notice }
      format.js { flash.now[:notice] = notice }
    end
  end

  private

  def set_card
    @card = SetCardOnIndex.call(user: current_user).card
  end
end
