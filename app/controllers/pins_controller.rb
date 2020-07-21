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
    @pin = Pin.new(pin_params)
    redirect_to pins_path
  end

  private

    def pin_params
      params.require(:pin).permit(:title, :image_url, :tag)
    end
    
end
