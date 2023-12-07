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
