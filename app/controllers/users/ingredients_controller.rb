class Users::IngredientsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @ingredients = current_user.ingredients
    @comment = Comment.new
  end
  
  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user_id = current_user.id
    genre = @ingredient.genre
    if @ingredient.save
      redirect_to genre_path(genre.id)
    else
      render :new
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end
  
  def update
    ingredient = Ingredient.find(params[:id])
    ingredient.update(ingredient_params)
    genre = ingredient.genre
    redirect_to genre_path(genre.id)  
  end
  
  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    redirect_to request.referer
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(
      :genre_id, :name, :expiration_date, :purchase_date, :quantity, :unit
    )
  end
end
