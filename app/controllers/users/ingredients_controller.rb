class Users::IngredientsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    case params[:sort]
    when "name_sort" then #50音順
                                                       #漢字、カタカナをひらがなに変換して並べる
      @ingredients = Kaminari.paginate_array(current_user.ingredients.sort_by {|i| [i.name.to_kanhira.to_hira, i]}).page(params[:page])
    when "date_sort_latest" then #登録が新しい順
      @ingredients = current_user.ingredients.latest.page(params[:page])
    when "date_sort_old" then #登録が古い順
      @ingredients = current_user.ingredients.old.page(params[:page])
    when "purchase_date_latest" then #購入日が新しい順
      @ingredients = current_user.ingredients.purchase_date_latest.page(params[:page])
    when "purchase_date_old" then #購入日が古い順
      @ingredients = current_user.ingredients.purchase_date_old.page(params[:page])
    when "expiration_date_latest" then #賞味期限が遠い順
      @ingredients = current_user.ingredients.expiration_date_latest.page(params[:page])
    when "expiration_date_old" then #賞味期限が近い順
      @ingredients = current_user.ingredients.expiration_date_old.page(params[:page])
    else
      @ingredients = current_user.ingredients.page(params[:page])
    end
    #食材のメモ機能
    @comment = Comment.new
  end
  
  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.genre_id = ingredient_params[:genre_id].blank? ? nil : ingredient_params[:genre_id]
    @ingredient.user_id = current_user.id
    if @ingredient.save# !をつけるならtry catch
      redirect_to @ingredient.genre_id.nil? ? genre_path(0) : genre_path(@ingredient.genre)
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
    redirect_to ingredient.genre_id.nil? ? genre_path(0) : genre_path(ingredient.genre) 
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
