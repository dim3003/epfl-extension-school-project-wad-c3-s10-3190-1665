class GoalsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    pin = Pin.find(params[:pin_id])
    user.goals << pin
    redirect_to(pin_path(pin))
  end

end
