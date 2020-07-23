class CommentsController < ApplicationController
  def create
    user = User.find(session[:user_id])
    comment = Comment.new(comment_params)
    pin = Pin.find(params[:pin_id])
    comment.pin = pin
    comment.user = user
    comment.save
    redirect_to idea_path(idea)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
