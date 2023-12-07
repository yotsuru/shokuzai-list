class Users::IngredientsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @ingredients = current_user.ingredients
    
    if params[:name_kana]#50音順
     @ingredients = Ingredient.name_kana
    elsif params[:latest]#登録が新しい順
     @ingredients = Ingredient.latest
    elsif params[:old]#登録が古い順
     @ingredients = Ingredient.old
    elsif params[:purchase_date_latest]#購入日が新しい順
     @ingredients = Ingredient.purchase_date_latest
    elsif params[:purchase_date_old]#購入日が古い順
     @ingredients = Ingredient.purchase_date_old
    elsif params[:expiration_date_latest]#賞味期限が遠い順
     @ingredients = Ingredient.expiration_date_latest
    elsif params[:expiration_date_old]#賞味期限が近い順
     @ingredients = Ingredient.expiration_date_old
    else
     @ingredients = Ingredient.all
    end
    
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
