class PinsController < ApplicationController
  def edit
    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
    else
      @user = nil
    end
    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    if(@pin.update(pin_params))
      redirect_to pins_path
    else
      render 'edit'
    end
  end

  def index
    if(params[:q])
      @search_term = params[:q]
      @pins = Pin.search(@search_term)
    else
      @pins = Pin.all
    end

    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
    else
      @user = nil
    end
  end

  def new
    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
    else
      @user = nil
    end
    @pin = Pin.new
  end

  def show
    @pin =Pin.find(params[:id])
    @comment = Comment.new

    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
      @disable_add_goal = @user.goals.exists?(@pin.id)
    else
      @user = nil
    end
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
