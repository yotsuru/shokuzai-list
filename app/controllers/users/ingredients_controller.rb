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
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(
      :genre_id, :name, :expiration_date, :purchase_date, :quantity, :unit
    )
  end
end
