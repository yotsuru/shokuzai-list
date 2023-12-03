class Users::GenresController < ApplicationController
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
    #@ingredients = Ingredient.find(params[:id])
    #@ingredients = Genre.ingredient.all
     @ingredients = Ingredient.all
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
