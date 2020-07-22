class PinsController < ApplicationController
  def edit
  end

  def index
    @pins = Pin.all
    @user = User.find(session[:user_id])
  end

  def new
    @pin = Pin.new
  end

  def show
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.save!
    redirect_to pins_path
  end

  private

    def pin_params
      params.require(:pin).permit(:title, :image_url, :tag)
    end

end
