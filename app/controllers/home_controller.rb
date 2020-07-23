class HomeController < ApplicationController
  def index
    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
    else
      @user = nil
    end
    @pins = Pin.all.most_recent
  end
end
