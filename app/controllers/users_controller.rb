class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
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

  def update
    if @user.update(users_params)
      redirect_back_or_to root_path
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
