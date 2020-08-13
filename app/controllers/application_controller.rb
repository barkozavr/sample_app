class ApplicationController < ActionController::Base
	include SessionsHelper

  private

#Подтверждение, что пользователь залогинился

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Пожалуйста, войдите в аккаунт"
      redirect_to login_url
    end
  end

end

