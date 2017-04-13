class UserSessionsController < ApplicationController
  def new
  end

  def create
    if user = login(params[:user_session][:email], params[:user_session][:password])
      redirect_back_or_to root_path, notice: 'Успешный вход'
    else
      flash.now[:alert] = 'Вы не смогли войти'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Вы вышли!'
  end
end
