module Home
  class UsersController < ApplicationController
    skip_before_action :require_login

    def new
      @user = User.new
    end

    def create
      @user = User.new(users_params)
      if @user.save
        auto_login(@user)
        redirect_to root_path, notice: t('.success')
      else
        render :new
      end
    end

    private

    def users_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id, :locale)
    end
  end
end
