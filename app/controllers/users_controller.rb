class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: 'Вы зарегистрировались'
    else
      render :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end