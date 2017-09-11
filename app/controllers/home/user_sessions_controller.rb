module Home
  class UserSessionsController < ApplicationController
    skip_before_action :require_login
    def new; end

    def create
      if login(params[:user_session][:email], params[:user_session][:password])
        redirect_back_or_to root_path, notice: t('.success')
      else
        flash.now[:alert] = t('.fail')
        render action: 'new'
      end
    end
  end
end
