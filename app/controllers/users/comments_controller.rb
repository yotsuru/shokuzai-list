class Users::CommentsController < ApplicationController
    
    
  def create
    ingredient = Ingredient.find(params[:ingredient_id])
    comment = ingredient.comments.new(comment_params)
    # comment.ingredient_id = ingredient.id
    comment.save
    genre = ingredient.genre
    #redirect_to genre_path(genre.id)
    redirect_to request.referer
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    #genre = ingredient.genre
    #redirect_to genre_path(genre.id)
    redirect_to request.referer
  end
  
  
  
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
