class Users::IngredientsController < ApplicationController
  def index
    @ingredients = current_user.ingredients
  end
  
  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user_id = current_user.id
    if @ingredient.save
      redirect_to ingredients_path
    else
      render :new
    end
  end

  def show
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
