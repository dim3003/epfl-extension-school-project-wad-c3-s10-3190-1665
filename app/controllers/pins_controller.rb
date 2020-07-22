class PinsController < ApplicationController
  def edit
  end

  def index
    @pins = Pin.all
  end

  def new
    @pin = Pin.new
  end

  def show
  end

  def create
    user = User.find(session[:user_id])
    @pin = Pin.new(pin_params)
    @pin.user = user
    if(@pin.save)
      redirect_to pins_path
    else
      render 'new'
    end
  end

  private

    def pin_params
      params.require(:pin).permit(:title, :image_url, :tag)
    end

end
