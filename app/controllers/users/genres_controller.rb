class Users::GenresController < ApplicationController
  before_action :authenticate_user!
  
  def index
    case params[:sort]
    when "name_sort" then #50音順
                                              #漢字、カタカナをひらがなに変換して並べる
       @genres = current_user.genres.sort_by {|i| [i.name.to_kanhira.to_hira, i]}
    when "date_sort_latest" then #登録が新しい順
       @genres = current_user.genres.latest
    when "date_sort_old" then #登録が古い順
       @genres = current_user.genres.old
    else
       @genres = current_user.genres
    end
    
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
    if params[:id].to_i == 0  #idが0ならnil=ジャンル"なし"
        @ingredients = Ingredient.where(user_id: current_user.id, genre: nil)
    else
        @genre = Genre.find(params[:id])
        @ingredients = @genre.ingredients #ジャンルに属した食材
    end
     case params[:sort]
     when "name_sort" then #50音順
                                          #漢字、カタカナをひらがなに変換して並べる
      @ingredients = @ingredients.sort_by {|i| [i.name.to_kanhira.to_hira, i]}
     when "date_sort_latest" then #登録が新しい順
      @ingredients = @ingredients.latest
     when "date_sort_old" then #登録が古い順
      @ingredients = @ingredients.old
     when "purchase_date_latest" then #購入日が新しい順
      @ingredients = @ingredients.purchase_date_latest
     when "purchase_date_old" then #購入日が古い順
      @ingredients = @ingredients.purchase_date_old
     when "expiration_date_latest" then #賞味期限が遠い順
      @ingredients = @ingredients.expiration_date_latest
     when "expiration_date_old" then #賞味期限が近い順
      @ingredients = @ingredients.expiration_date_old
     else
      @ingredients = @ingredients
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
