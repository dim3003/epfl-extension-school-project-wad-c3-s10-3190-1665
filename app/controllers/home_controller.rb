class HomeController < ApplicationController
  def index
    @pins = Pin.all.most_recent
  end
end
