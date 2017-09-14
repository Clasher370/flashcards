module Dashboard
  class UsersController < ApplicationController
    def edit
      @user = current_user
    end

    def update
      if current_user.update(users_params)
        redirect_back_or_to root_path
      else
        render 'edit'
      end
    end

    private

    def users_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id, :locale)
    end
  end
end
