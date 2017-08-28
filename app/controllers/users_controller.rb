# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def edit
    @user = current_user
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
