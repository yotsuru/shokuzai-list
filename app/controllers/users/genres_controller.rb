class Users::GenresController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @genres = current_user.genres
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    @genre.user_id = current_user.id
    if @genre.save
      redirect_to genres_path
    else
      @genres = current_user.genres
      render :index
    end
  end
  
  def show
    @genre = Genre.find(params[:id])
    #各ジャンルに属した食材
    @ingredients = @genre.ingredients
     if params[:name_kana]#50音順
      @ingredients = @genre.ingredients.name_kana
     elsif params[:latest]#登録が新しい順
      @ingredients = @genre.ingredients.latest
     elsif params[:old]#登録が古い順
      @ingredients = @genre.ingredients.old
     elsif params[:purchase_date_latest]#購入日が新しい順
      @ingredients = @genre.ingredients.purchase_date_latest
     elsif params[:purchase_date_old]#購入日が古い順
      @ingredients = @genre.ingredients.purchase_date_old
     elsif params[:expiration_date_latest]#賞味期限が遠い順
      @ingredients = @genre.ingredients.expiration_date_latest
     elsif params[:expiration_date_old]#賞味期限が近い順
      @ingredients = @genre.ingredients.expiration_date_old
     else
      @ingredients = @genre.ingredients
     end
    #食材のメモ機能
    @comment = Comment.new
    
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to genre_path(genre.id)
  end
  
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to genres_path
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
