class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "Genre"
      @genres = Genre.looks(params[:search], params[:name])
    else
      @ingredients = Ingredient.looks(params[:search], params[:name])
    end
    
    @comment = Comment.new
  end
end

