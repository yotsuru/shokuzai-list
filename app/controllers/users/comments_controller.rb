class Users::CommentsController < ApplicationController
    
    
  def create
    ingredient = Ingredient.find(params[:ingredient_id])
    comment = current_user.ingredient_comments.new(comment_params)
    comment.ingredient_id = ingredient.id
    comment.save
    genre = ingredient.genre
    redirect_to genre_path(genre.id)
  end
  
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
