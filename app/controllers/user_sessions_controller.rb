class UserSessionsController < ApplicationController
  def new
  end

  def create
    if user = login(params[:user_session][:email], params[:user_session][:password])
      redirect_back_or_to root_path, notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out!'
  end
end
