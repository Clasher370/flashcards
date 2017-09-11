module Dashboard
  class UserSessionsController < ApplicationController
    def destroy
      logout
      redirect_to home_login_path, notice: t('.logout')
    end
  end
end
