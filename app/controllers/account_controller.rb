class AccountController < ApplicationController
  def mypins
    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
    else
      @user = nil
    end

    @pins = @user.goals
  end
end
