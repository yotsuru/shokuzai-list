class Users::CommentsController < ApplicationController
  before_action :authenticate_user!
    
  def create
    ingredient = Ingredient.find(params[:ingredient_id])
    comment = ingredient.comments.new(comment_params)
    comment.save
    redirect_to request.referer
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to request.referer
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
