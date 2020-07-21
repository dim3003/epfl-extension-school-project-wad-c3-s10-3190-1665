class PinsController < ApplicationController
  def edit
  end

  def index
    @pins = Pin.all
  end

  def new
  end

  def show
  end
end
