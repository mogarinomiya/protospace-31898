class CommentsController < ApplicationController
  require 'pry'

  def create
    #render plain: params[:comment].inspect
    @comment = Comment.new(comment_params)
    @prototype = @comment.prototype
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  def show
    @comments = Comment.all
  end


  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
